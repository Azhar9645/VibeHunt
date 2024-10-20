import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/my_post/my_post_model.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/presentation/screens/profile/components/bottomsheets/comment_bottomsheet.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_comment_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_like_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_save_buttom.dart';
import 'package:vibehunt/presentation/screens/profile/components/post_listing_card.dart';
import 'package:vibehunt/presentation/screens/rive_screen.dart/rive_loading.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/utils/funtions.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  final List<MyPostModel> posts;
  final int index;

  const PostScreen({
    super.key,
    required this.posts,
    required this.index,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController commentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<Comment> _comments = [];

  @override
  void initState() {
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Posts',
          style: j24,
        ),
      ),
      body: BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
        builder: (context, state) {
          if (state is FetchMyPostLoadingState) {
            return const Center(child: RiveLoadingScreen());
          } else if (state is FetchMyPostSuccessState) {
            if (state.posts.isEmpty) {
              return const Center(child: Text('No posts available.'));
            }
            return ListView.builder(
              controller:
                  ScrollController(initialScrollOffset: widget.index * 500),
              itemBuilder: (context, index) {
                final postItem = state.posts[index];

                return PostListingCard(
                  mainImage:
                      postItem.image?.toString() ?? '', // Ensure fallback value
                  profileImage: postItem.userId?.profilePic ??
                      '', // Fallback for null profilePic
                  post: state.posts,
                  tags: postItem.tags ?? [], // Handle null tags
                  userName: postItem.userId?.userName?.toString() ??
                      'Unknown User', // Fallback for null username

                  // Handle null for createdAt and editedTime with proper checks
                  postTime: postItem.createdAt != null
                      ? (postItem.createdAt == postItem.editedTime
                          ? formatDate(
                              postItem.createdAt!) // Format DateTime to String
                          : "${formatDate(postItem.editedTime ?? DateTime.now())} (Edited)")
                      : 'Unknown Date',

                  description: postItem.description?.toString() ??
                      'No description available', // Fallback for null description
                  likeCount: postItem.likes?.length?.toString() ??
                      '0', // Fallback for null likes
                  commentCount:
                      '1', // Comment count, update dynamically if available

                  likeButtonPressed: () {
                    // Add functionality to like button if required
                  },

                  commentButtonPressed: () {
                    commentBottomSheet(
                      context, postItem, commentController,
                      formKey: _formkey,
                      comments: _comments,
                      id: postItem.id?.toString() ?? '', // Handle null id
                    );
                  },

                  index: index,
                );
              },
              itemCount: state.posts.length,
            );
          } else if (state is FetchMyPostErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No posts available.'));
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    // Use DateFormat to format DateTime into a readable string format
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
}
