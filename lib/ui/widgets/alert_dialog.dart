import 'package:flutter/material.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:go_router/go_router.dart';

/// Shows an [AlertDialog] when used. It requires a [title], the
/// [content] you want to display and an [onConfirm] function which
/// will be called on the confirm button. An optional parameter can
/// be provided for the cancel button which is [onCancel].
/// [onCancel] and [onConfirm] are both [Function] parameters.
/// [title] is a [String] and [content] is a [Widget].
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
  final Function() onConfirm;

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
