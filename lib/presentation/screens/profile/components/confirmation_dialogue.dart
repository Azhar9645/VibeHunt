import 'package:flutter/material.dart';
import 'package:vibehunt/utils/constants.dart';

void confirmationDialog(BuildContext context,
    {required String title,
    required String content,
    Color? agreeColor,
    required VoidCallback onpressed}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16))),
        content: Text(
          textAlign: TextAlign.center,
          content,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:kWhiteColor),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:kGrey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onpressed,
            child: const Text('Delete',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: kRed)),
          )
        ],
      );
    },
  );
}
