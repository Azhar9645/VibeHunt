import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vibehunt/data/models/my_post/my_post_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';
import 'package:vibehunt/presentation/screens/profile/components/confirmation_dialog.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/confirm_dialogue.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_comment_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_like_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_save_buttom.dart';
import 'package:vibehunt/presentation/screens/profile/components/post_edit_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostListingCard extends StatelessWidget {
  final List<MyPostModel> post;
  final String? mainImage; // Nullable 
  final String? profileImage; // Nullable
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final VoidCallback commentButtonPressed;
  final int index;
  final List<dynamic> tags;

  PostListingCard({
    Key? key,
    required this.mainImage,
    required this.profileImage,
    required this.post,
    required this.userName,
    required this.postTime,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.likeButtonPressed,
    required this.commentButtonPressed,
    required this.index,
    required this.tags,
  }) : super(key: key);

  String _truncateDescription(String text) {
    final words = text.split(' ');
    if (words.length > 2) {
      return '${words.sublist(0, 2).join(' ')}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(mainImage ?? ''),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => PostEditScreen(
                    model: post[index],
                  ),
                ),
              );
            },
            backgroundColor: kBlackColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) async {
              debugPrint("Delete button clicked");

              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete Post"),
                    content: const Text(
                        "Are you sure you want to delete this post?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: const Text("Yes"),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Close the dialog before proceeding

                          // Dispatch the PostDeleteButtonPressedEvent to Bloc
                          BlocProvider.of<FetchMyPostBloc>(context).add(
                            PostDeleteButtonPressedEvent(
                                postId: post[index].id.toString()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: kBlackColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: Card(
        color: kGrey,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile and username row
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kGreen,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        profileImage ??
                            'https://via.placeholder.com/150', // Fallback image
                        width: 70,
                        height: 70,
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
                      Text(userName, style: j20),
                      Text(
                        postTime, // Fallback if postTime is null
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Main post image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  mainImage ??
                      'https://via.placeholder.com/400', // Fallback image
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              // Description, tags, and interaction icons
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _truncateDescription(description),
                          style: const TextStyle(
                            fontSize: 18,
                            color: kWhiteColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        // Display tags
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
                  Column(
                    children: [
                      Row(
                        children: [
                          CustomLikeButton(),
                          CustomCommentButton(
                            onPressed: commentButtonPressed,
                          ),
                          CustomSaveButton(
                            isSaved: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('$likeCount likes'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('$commentCount Comments')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
