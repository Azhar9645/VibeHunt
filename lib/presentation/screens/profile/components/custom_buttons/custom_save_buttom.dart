import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomSaveButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onPressed;

  const CustomSaveButton({super.key, required this.isSaved, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Fixed width
      height: 50, // Fixed height
      alignment: Alignment.center,
      child: LikeButton(
        isLiked: isSaved,
        circleColor: const CircleColor(start: Colors.white, end: Colors.white),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Colors.white,
          dotSecondaryColor: Colors.white,
        ),
        likeBuilder: (bool isLiked) {
          return Icon(
            isLiked ? Icons.bookmark : Icons.bookmark_border,
            color: isLiked ? Colors.white : Colors.white,
            size: 35,
          );
        },
        onTap: (bool isLiked) async {
          onPressed(); // Perform save/unsave action
          return !isLiked; // Toggle the state
        },
      ),
    );
  }
}