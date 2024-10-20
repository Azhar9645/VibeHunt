import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:vibehunt/data/models/following_post_model.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/data/models/profile/following_user_model.dart';
import 'package:vibehunt/data/models/profile/post_user_model.dart';
import 'package:vibehunt/data/models/saved_post_model.dart';
import 'package:vibehunt/presentation/screens/profile/components/bottomsheets/comment_bottomsheet.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_comment_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_like_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_save_buttom.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/save_post/save_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget buildPostTile(
    {required BuildContext context,
    required FollowingPostModel model,
    required TextEditingController commentController,
    required GlobalKey<FormState> formKey,
    required List<Comment> comments,
    required VoidCallback onCommentTap,
    required List<SavedPostModel> savedposts}) {
  final currentUserId = userdetails.id;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onDoubleTap: () {
        final isLiked = model.likes.any((user) => user.id == currentUserId);
        if (!isLiked) {
          model.likes.add(FollowingUserIdModel.fromJson(User(
                  id: userdetails.id,
                  userName: userdetails.userName,
                  email: userdetails.email,
                  profilePic: userdetails.profilePic,
                  phone: userdetails.phone,
                  online: userdetails.online,
                  blocked: userdetails.blocked,
                  verified: userdetails.verified,
                  createdAt: userdetails.createdAt,
                  updatedAt: userdetails.updatedAt,
                  v: 1,
                  role: userdetails.role,
                  backGroundImage: userdetails.backGroundImage,
                  isPrivate: userdetails.isPrivate)
              .toJson()));
          context
              .read<LikeUnlikeBloc>()
              .add(LikeButtonClickEvent(postId: model.id.toString()));
        } else {
          model.likes.removeWhere((user) => user.id == currentUserId);
          context
              .read<LikeUnlikeBloc>()
              .add(UnlikeButtonClickEvent(postId: model.id.toString()));
        }
      },
      child: Card(
        color: kGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile and Name
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        model.userId.profilePic ??
                            'https://via.placeholder.com/150',
                        width: 60,
                        height: 60,
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
                        model.userId.userName ?? 'Unknown user',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        model.createdAt != null
                            ? timeago.format(model.createdAt)
                            : 'Unknown time',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Post Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  model.image ?? 'https://via.placeholder.com/400',
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
              // Post Description and Tags
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.description ?? 'No description available',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: model.tags
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
                  // Post Buttons (Like, Comment, Save)
                  MultiBlocBuilder(
                    blocs: [
                      context.watch<LikeUnlikeBloc>(),
                      context.watch<FetchSavedPostBloc>(),
                      context.watch<SavePostBloc>(),
                    ],
                    builder: (context, state) {
                      var state2 = state[1];
                      if (state2 is FetchSavedPostSuccessState) {
                        savedposts = state2.posts;
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  final isLiked = model.likes
                                      .any((user) => user.id == currentUserId);
                                  if (!isLiked) {
                                    model.likes.add(
                                        FollowingUserIdModel.fromJson(User(
                                                id: userdetails.id,
                                                userName: userdetails.userName,
                                                email: userdetails.email,
                                                profilePic:
                                                    userdetails.profilePic,
                                                phone: userdetails.phone,
                                                online: userdetails.online,
                                                blocked: userdetails.blocked,
                                                verified: userdetails.verified,
                                                createdAt:
                                                    userdetails.createdAt,
                                                updatedAt:
                                                    userdetails.updatedAt,
                                                v: 1,
                                                role: userdetails.role,
                                                backGroundImage:
                                                    userdetails.backGroundImage,
                                                isPrivate:
                                                    userdetails.isPrivate)
                                            .toJson()));
                                    context.read<LikeUnlikeBloc>().add(
                                        LikeButtonClickEvent(
                                            postId: model.id.toString()));
                                  } else {
                                    model.likes.removeWhere(
                                        (user) => user.id == currentUserId);
                                    context.read<LikeUnlikeBloc>().add(
                                        UnlikeButtonClickEvent(
                                            postId: model.id.toString()));
                                  }
                                },
                                icon: Icon(
                                  model.likes.any(
                                          (user) => user.id == userdetails.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: model.likes.any(
                                          (user) => user.id == userdetails.id)
                                      ? kRed
                                      : kGreen,
                                ),
                                iconSize: 35,
                              ),
                              IconButton(
                                onPressed: onCommentTap,
                                icon: const Icon(
                                  Icons.mode_comment_outlined,
                                ),
                                iconSize: 35,
                                color: kGreen,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (savedposts.any((element) =>
                                      element.postId.id == model.id)) {
                                    context.read<SavePostBloc>().add(
                                        UnSaveButtonClickedEvent(
                                            postId: model.id.toString()));
                                    savedposts.removeWhere((element) =>
                                        element.postId.id == model.id);
                                  } else {
                                    savedposts.add(SavedPostModel(
                                        userId: model.userId.id.toString(),
                                        postId: PostId(
                                            id: model.id.toString(),
                                            userId: UserIdSavedPost.fromJson(
                                                model.userId.toJson()),
                                            image: model.image.toString(),
                                            description:
                                                model.description.toString(),
                                            likes: model.likes,
                                            hidden: model.hidden,
                                            blocked: model.blocked,
                                            tags: model.tags,
                                            date: model.date,
                                            createdAt: model.createdAt,
                                            updatedAt: model.updatedAt,
                                            v: model.v,
                                            taggedUsers: model.taggedUsers),
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        v: model.v));
                                    context.read<SavePostBloc>().add(
                                        SaveButtonClickedEvent(
                                            postId: model.id.toString()));
                                  }
                                },
                                icon: Icon(
                                  savedposts.any((element) =>
                                          element.postId.id == model.id)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: kGreen,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${model.likes.length} Likes',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${model.commentCount} Comments',
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
    ),
  );
}
