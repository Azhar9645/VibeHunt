import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/utils/constants.dart';

Future<dynamic> commentBottomSheet(
    BuildContext context, post, TextEditingController commentController,
    {required GlobalKey<FormState> formkey,
    required List<Comment> comments,
    required String id}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                0.8, // Restrict height to 80% of screen height
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              // Title Bar with Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Comments',
                    textAlign: TextAlign.center,
                    style: j24,
                  ),
                ],
              ),
              const Divider(height: 1),

              // Comments List
              Expanded(
                child: comments.isEmpty
                    ? const Center(child: Text('No comments yet.'))
                    : ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          Comment comment = comments[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                      NetworkImage(comment.user.profilePic),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment.user.userName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        comment.content,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        timeago.format(comment.createdAt,
                                            locale: 'en_short'),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (logginedUserId == comment.user.id)
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.grey),
                                    onPressed: () {
                                      // Handle comment deletion here
                                    },
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Divider above the comment input field
              const Divider(height: 1),

              // Comment Input Field
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: formkey,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(logginedUserProfileImage),
                        radius: 25,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: kBlackColor,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a comment';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: kGreen),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            // Handle posting the comment here
                            Comment newComment = Comment(
                              id: UniqueKey().toString(),
                              content: commentController.text,
                              createdAt: DateTime.now(),
                              user: CommentUser(
                                id: logginedUserId,
                                userName: profileuserName,
                                profilePic: logginedUserProfileImage,
                              ),
                            );
                            comments.add(newComment);
                            commentController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
