import 'package:flutter/material.dart';

Future<void> logoutConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required String cancelButtonText,
  required Function onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(cancelButtonText),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              await onConfirm(); // Execute the confirmation action
            },
            child: Text(confirmButtonText),
          ),
        ],
      );
    },
  );
}
