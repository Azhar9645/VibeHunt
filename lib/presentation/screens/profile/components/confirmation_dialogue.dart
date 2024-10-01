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
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.light
                    ? kGrey
                    : kGrey)),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.light
                        ? kGrey
                        : kGrey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onpressed,
            child:const Text('Delete',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: kRed)),
          )
        ],
      );
    },
  );
}