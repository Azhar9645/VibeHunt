import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';

class SavedPostTile extends StatelessWidget {
  final String profileImage;
  final String mainImage;
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback? commentButtonPressed;
  final Future<void> Function() removeSaved;
  final FetchSavedPostSuccessState statesaved;
  final int index;

  const SavedPostTile({
    super.key,
    required this.mainImage,
    required this.profileImage,
    required this.userName,
    required this.postTime,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.index,
    required this.removeSaved,
    required this.statesaved,
    required this.likeButtonPressed,
    required this.commentButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User profile and name
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/default_profile.png');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      // Text(
                      //   timeago.format(DateTime.parse(postTime)),
                      //   style: const TextStyle(fontSize: 12, color: Colors.grey),
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Main post image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  mainImage,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      height: 250,
                      child: const Center(child: Icon(Icons.error, color: Colors.red)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Post description
              Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              // Interaction buttons (like, comment, save)
              Row(
                children: [
                  IconButton(
                    onPressed: likeButtonPressed,
                    icon: Icon(Icons.favorite_border, color: Colors.green, size: 35),
                  ),
                  IconButton(
                    onPressed: commentButtonPressed,
                    icon: const Icon(Icons.mode_comment_outlined, color: Colors.green, size: 35),
                  ),
                  IconButton(
                    onPressed: removeSaved,
                    icon: const Icon(Icons.bookmark_border, color: Colors.green, size: 35),
                  ),
                ],
              ),
              // Likes and comments count
              Row(
                children: [
                  Text(
                    '$likeCount Likes',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$commentCount Comments',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
