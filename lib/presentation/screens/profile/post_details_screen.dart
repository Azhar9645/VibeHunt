import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/my_post/my_post_model.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/presentation/screens/profile/components/comment_bottomsheet.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_comment_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_like_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_save_buttom.dart';
import 'package:vibehunt/presentation/screens/profile/components/post_listing_card.dart';
import 'package:vibehunt/presentation/screens/rive_screen.dart/rive_loading.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/utils/funtions.dart';

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
                  ScrollController(initialScrollOffset: widget.index * 700),
              itemBuilder: (context, index) {
                final postItem = state.posts[index];
                return PostListingCard(
                  mainImage: postItem.image.toString(),
                  profileImage: postItem.userId?.profilePic ?? '',
                  post: state.posts,
                  tags: postItem.tags ?? [],
                  userName: postItem.userId?.userName.toString() ?? '',
                  postTime: postItem.createdAt == postItem.editedTime
                      ? formatDate(postItem.createdAt.toString())
                      : ("${formatDate(postItem.editedTime.toString())} (Edited)"),
                  description: postItem.description.toString(),
                  likeCount: postItem.likes!.length.toString(),
                  commentCount: '1', // need to add
                  likeButtonPressed: () {},
                  commentButtonPressed: () {
                    
                    commentBottomSheet(context, postItem, commentController,
                        formkey: _formkey,
                        comments: _comments,
                        id: postItem.id.toString());
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
}
