import 'package:flutter/material.dart';
import 'package:vibehunt/utils/constants.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kGreen,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Make it a capsule shape
        ),
        elevation: 7.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 45,
          ),
          Text(text, style: jStyleW),
          Container(
            width: 40, // Width of the circle
            height: 40, // Height of the circle
            decoration: const BoxDecoration(
              color: Colors.white, // Background color of the circle
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: kGreen, // Arrow color
              size: 25, // Arrow size
            ),
          ),
        ],
      ),
    );
  }
}
