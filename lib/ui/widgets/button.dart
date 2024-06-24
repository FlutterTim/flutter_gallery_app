import 'package:flutter/material.dart';
import 'package:flutter_gallery/theme.dart';

/// [Button] is an object that provides an [ElevatedButton]
/// You need to provide a [buttonText] which is the text that will
/// be displayed on the button, and also an [onPressed] function
/// that will be called when you click on the button.
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
      style: darkTheme.elevatedButtonTheme.style,
      child: Text(buttonText),
    );
  }
}
