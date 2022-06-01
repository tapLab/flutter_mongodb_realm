import 'package:flutter/material.dart';

class SizedProgressIndicator extends StatelessWidget {
  final double size;

  const SizedProgressIndicator({Key? key, this.size = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
