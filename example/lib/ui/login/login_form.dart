import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/sized_progress_indicator.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_event.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_state.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;

  const LoginForm({
    Key? key,
    required this.loginBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;
  String text = "";

  @override
  void initState() {
    if (kDebugMode) {
      print('xxx is in debug mode');
      _usernameController.text = ''; // preset user name
      _passwordController.text = ''; // preset password
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String labelTextUser = 'User';
    const String labelTextPassword = 'Password';
    const String loginButtonText = 'Login';

    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        double width = MediaQuery.of(context).size.width;
        double nwidth = width * 0.65;

        return Form(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: nwidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey('userNameField'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: labelTextUser,
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _usernameController,
                        onChanged: (String newText) {
                          _fixUsernameTextInput(newText);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const ValueKey('passwordField'),
                        decoration: const InputDecoration(
                          labelText: labelTextPassword,
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                    ),
                    TextButton(
                        onPressed: state is! LoginLoading
                            ? _onLoginButtonPressed
                            : null,
                        child: const Text(loginButtonText)),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: state is LoginLoading
                          ? const SizedProgressIndicator()
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _fixUsernameTextInput(String newText) {
    int midpoint = newText.length ~/ 2;
    int lastLetterIndex = newText.length - 1;

    if (newText.length != 1 && newText.length == text.length * 2 + 1) {
      String firstHalf = newText.substring(0, midpoint);
      String secondHalf = newText.substring(midpoint, lastLetterIndex);

      if (firstHalf == secondHalf) {
        _usernameController.text = newText.substring(midpoint, newText.length);
        text = newText.substring(midpoint, newText.length);
        TextSelection textSelected =
            TextSelection.fromPosition(TextPosition(offset: text.length));
        _usernameController.selection = textSelected;
      }
    } else {
      text = newText;
    }
  }

  _onLoginButtonPressed() {
    _loginBloc.add(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}
