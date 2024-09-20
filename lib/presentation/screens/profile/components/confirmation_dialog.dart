import 'package:flutter/material.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required String cancelButtonText,
  required VoidCallback onConfirm,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(cancelButtonText),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text(confirmButtonText),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Call the onConfirm callback to delete the post
            },
          ),
        ],
      );
    },
  );
}
