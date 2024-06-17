import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    required this.onPressed,
    required this.buttonText,
    super.key,
  });

  final Function() onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
