import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_following_post/fetch_all_following_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class SavedPostTile extends StatelessWidget {
  final String profileImage;
  final String mainImage;
  final String userName;
  final String postTime;
  final String description;
  final List<dynamic> tags;

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
    required this.tags,
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
    final post = statesaved.posts[index];

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
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(postTime),
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
                      child: const Center(
                          child: Icon(Icons.error, color: Colors.red)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Post description
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: tags
                              .map((tag) => Text(
                                    '#${tag.toString()}',
                                    style: const TextStyle(
                                      color: kGreen,
                                      fontSize: 16,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
                    builder: (context, state) {
                      bool isLiked = post.postId.likes.contains(logginedUserId);
                      int currentLikeCount = post.postId.likes.length;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (isLiked) {
                                    context.read<LikeUnlikeBloc>().add(
                                          UnlikeButtonClickEvent(
                                              postId: post.postId.id),
                                        );

                                    post.postId.likes.remove(logginedUserId);
                                  } else {
                                    context.read<LikeUnlikeBloc>().add(
                                          LikeButtonClickEvent(
                                              postId: post.postId.id),
                                        );

                                    post.postId.likes.add(logginedUserId);
                                  }

                                  context.read<FetchAllFollowingPostBloc>().add(
                                      AllFollowingsPostsInitialFetchEvent());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLiked ? kRed : kGreen,
                                    size: 35,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: commentButtonPressed,
                                icon: const Icon(
                                  Icons.mode_comment_outlined,
                                  color: kGreen,
                                ),
                                iconSize: 35,
                              ),
                              IconButton(
                                onPressed: () async {
                                  // Call the removeSaved function to unsave the post
                                  await removeSaved();

                                  // Optionally, you can show a snack bar or toast message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Post removed from saved.'),
                                    ),
                                  );

                                  // Refresh the saved posts by triggering an event
                                  context
                                      .read<FetchSavedPostBloc>()
                                      .add(SavedPostsInitialFetchEvent());
                                },
                                icon: const Icon(
                                  Icons.bookmark,
                                  color: kGreen,
                                ),
                                iconSize: 35,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '$currentLikeCount likes',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '$commentCount Comments',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
