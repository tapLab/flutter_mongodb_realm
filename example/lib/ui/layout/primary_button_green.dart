import 'package:flutter/material.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/single_button.dart';

class PrimaryButtonGreen extends StatelessWidget {
  final String text;
  final String? subtext;
  final VoidCallback onPressed;

  PrimaryButtonGreen(
      {required this.text, this.subtext, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SingleButton(
        text: text,
        subtext: subtext,
        primary: true,
        backgroundColorDark: Colors.green[700],
        backgroundColorLight: Colors.lightGreen,
        onPressed: onPressed);
  }
}
