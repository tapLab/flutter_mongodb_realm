import 'package:flutter_mongodb_realm_example/ui/layout/single_button.dart';
import 'package:flutter/material.dart';

class PrimaryButtonBlue extends StatelessWidget {
  final String text;
  final String? subtext;
  final VoidCallback? onPressed;

  const PrimaryButtonBlue(
      {Key? key, required this.text, this.subtext, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleButton(
        text: text,
        subtext: subtext,
        primary: true,
        backgroundColorDark: Colors.blue[700],
        backgroundColorLight: Colors.lightBlue,
        onPressed: onPressed);
  }
}
