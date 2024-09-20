import 'package:flutter/material.dart';

// Assuming your constants are defined as follows:
const Color kDialogBackgroundColor = Color(0xFF1E1E1E); // Dark grey background
const Color kPrimaryTextColor = Color(0xFFFFFFFF); // White text
const Color kSecondaryTextColor = Color(0xFFB0B0B0); // Light grey text
const Color kButtonBackgroundColor = Color(0xFF4CAF50); // Green for buttons
const Color kCancelTextColor = Color(0xFFFFFFFF); // White text for cancel button
const Color kConfirmButtonBackgroundColor = Color(0xFFE53935); // Red for confirm button
const Color kConfirmTextColor = Color(0xFFFFFFFF); // White text for confirm button

const TextStyle showdialogueHeadingstyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: kPrimaryTextColor,
);

const TextStyle showdialogueContentStyle = TextStyle(
  fontSize: 16,
  color: kSecondaryTextColor,
);

const TextStyle showDialogueButtonStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kCancelTextColor,
);

const TextStyle showDialogueButtonStyle2 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kConfirmTextColor,
);

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required String cancelButtonText,
  required Future<void> Function() onConfirm,
  VoidCallback? onCancel,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: kDialogBackgroundColor, // Set to match app's theme
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // App's custom radius
        ),
        title: Text(
          title,
          style: showdialogueHeadingstyle,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                content,
                style: showdialogueContentStyle,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // Cancel Button
          TextButton(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              }
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Consistent button shape
              ),
              backgroundColor: kButtonBackgroundColor, // App's button color
            ),
            child: Text(
              cancelButtonText,
              style: showDialogueButtonStyle,
            ),
          ),
          // Confirm Button
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog
              await onConfirm(); // Execute confirm action
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Consistent button shape
              ),
              backgroundColor: kConfirmButtonBackgroundColor, // Confirm button color
            ),
            child: Text(
              confirmButtonText,
              style: showDialogueButtonStyle2,
            ),
          ),
        ],
      );
    },
  );
}
