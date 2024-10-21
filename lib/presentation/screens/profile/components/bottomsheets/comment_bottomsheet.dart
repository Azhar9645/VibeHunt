import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/screens/profile/components/bottomsheets/comment_shimmer.dart';
import 'package:vibehunt/presentation/screens/profile/components/confirmation_dialogue.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/create_comment/create_comment_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/delete_comment/delete_comment_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

Future<dynamic> commentBottomSheet(
    BuildContext context, post, TextEditingController commentController,
    {required GlobalKey<FormState> formKey,
    required List<Comment> comments,
    required String id}) {
  // List of emojis to display
  List<String> emojis = [
    "😀",
    "😂",
    "😍",
    "😢",
    "😎",
    "👍",
    "👎",
    "🎉",
    "🔥",
    "❤️"
  ];

  return showModalBottomSheet(
    context: context,
    backgroundColor: kGrey,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      builder: (context, scrollController) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('Comments', style: j24),
            ),
            Divider(
              color: Colors.grey[700],
              thickness: 1,
            ),
            Expanded(
              child: BlocBuilder<FetchAllCommentsBloc, FetchAllCommentsState>(
                builder: (context, state) {
                  if (state is FetchAllCommentsLoadingState) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return CommentShimmer();
                      },
                    );
                  } else if (state is FetchAllCommentsSuccessState) {
                    comments = state.comments;
                    return comments.isEmpty
                        ? const Center(
                            child: Text('No comments yet.',
                                style: TextStyle(color: Colors.white)))
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage:
                                          NetworkImage(comment.user.profilePic),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment.user.userName,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            comment.content,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            timeago.format(comment.createdAt,
                                                locale: 'en_short'),
                                            style: const TextStyle(
                                                fontSize: 12, color: kGreen),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (logginedUserId == comment.user.id)
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_rounded,
                                          color: kWhiteColor,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          confirmationDialog(context,
                                              title: 'Delete',
                                              content:
                                                  'Are you sure you want to delete this comment?',
                                              onpressed: () {
                                            Navigator.pop(context);
                                            context.read<DeleteCommentBloc>().add(
                                                DeleteCommentButtonClickEvent(
                                                    commentId: comment.id));
                                          });
                                        },
                                      )
                                  ],
                                ),
                              );
                            },
                          );
                  } else if (state is FetchAllCommentsErrorState) {
                    return const Center(
                        child:
                            Text('Error', style: TextStyle(color: Colors.red)));
                  } else {
                    return const Center(
                        child: Text('No comments available.',
                            style: TextStyle(color: Colors.white)));
                  }
                },
              ),
            ),
            const Divider(color: Colors.white),
            // Emoji row
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: emojis.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Append emoji to the comment field when tapped
                      commentController.text += emojis[index];
                      commentController.selection = TextSelection.fromPosition(
                        TextPosition(offset: commentController.text.length),
                      );
                    },
                    child: Text(
                      emojis[index],
                      style: const TextStyle(fontSize: 25), // Emoji size
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(logginedUserProfileImage),
                    backgroundColor: kGrey,
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: MultiBlocListener(
                        listeners: [
                          BlocListener<DeleteCommentBloc, DeleteCommentState>(
                            listener: (context, state) {
                              if (state is DeleteCommentSuccesfulState) {
                                context
                                    .read<FetchAllCommentsBloc>()
                                    .add(CommentsFetchEvent(postId: id));
                                comments.removeWhere(
                                    (comment) => comment.id == state.commentId);
                              }
                            },
                          ),
                          BlocListener<CreateCommentBloc, CreateCommentState>(
                            listener: (context, state) {
                              if (state is CreateCommentSuccessState) {
                                context
                                    .read<FetchAllCommentsBloc>()
                                    .add(CommentsFetchEvent(postId: id));
                                commentController.clear();
                              }
                            },
                          ),
                        ],
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            hintText: 'Write a comment...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            fillColor: Colors.grey[800],
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Write a comment';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<CreateCommentBloc>().add(
                              CommentPostButtonClickEvent(
                                  userName: profileuserName,
                                  postId: id,
                                  content: commentController.text),
                            );
                      }
                    },
                    icon: const Icon(Icons.send, color: kGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
