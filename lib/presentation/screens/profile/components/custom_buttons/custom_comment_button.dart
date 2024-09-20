import 'package:flutter/material.dart';

class CustomCommentButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomCommentButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          Icons.mode_comment_outlined,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
