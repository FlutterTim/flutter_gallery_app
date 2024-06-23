import 'package:flutter/material.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:go_router/go_router.dart';

class GalleryAlertDialog extends StatelessWidget {
  const GalleryAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onCancel,
    required this.onConfirm,
  });

  final String title;
  final Widget content;
  final Function()? onCancel;
  final Future Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    var localizations = context.localizations;

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: content),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => context.pop(),
          child: Text(
            localizations.no,
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            localizations.yes,
          ),
        ),
      ],
    );
  }
}
