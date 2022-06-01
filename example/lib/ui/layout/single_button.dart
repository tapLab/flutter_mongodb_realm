import 'package:flutter/material.dart';

class SingleButton extends StatelessWidget {
  final String text;
  final String? subtext;
  final Color? backgroundColorDark;
  final Color? backgroundColorLight;
  final bool primary;
  final double fontSize;
  final VoidCallback? onPressed;

  const SingleButton({
    Key? key,
    required this.text,
    this.subtext,
    this.backgroundColorDark,
    this.backgroundColorLight,
    required this.primary,
    this.fontSize = 12.0,
    this.onPressed,
  }) : super(key: key);

  Color getColorForNonPrimary() {
    return onPressed != null ? Colors.blue.shade700 : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: primary == true
                    ? null
                    : Border.all(color: getColorForNonPrimary()),
                gradient: primary
                    ? LinearGradient(
                        colors: [
                          onPressed == null
                              ? Colors.grey
                              : backgroundColorLight!,
                          onPressed == null ? Colors.grey : backgroundColorDark!
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.5, 0.0),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp)
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: primary == true
                          ? Colors.white
                          : getColorForNonPrimary(),
                      fontSize: fontSize,
                    ),
                  ),
                  if (subtext != null) ...[
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      subtext!,
                      style: TextStyle(
                        color: primary ? Colors.white : Colors.blue.shade700,
                        fontSize: 9.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
