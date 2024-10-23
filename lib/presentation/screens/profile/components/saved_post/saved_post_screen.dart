import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/data/models/saved_post_model.dart';
import 'package:vibehunt/presentation/screens/profile/components/bottomsheets/comment_bottomsheet.dart';
import 'package:vibehunt/presentation/screens/profile/components/saved_post/saved_post_tile.dart';
import 'package:vibehunt/presentation/screens/profile/widgets/shimmertile.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/save_post/save_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/utils/funtions.dart';

class SavedScreenPost extends StatelessWidget {
  SavedScreenPost({super.key, required this.model});

  final List<SavedPostModel> model;
  TextEditingController commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<Comment> _comments = [];
  List<SavedPostModel> savedposts = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Saved Posts',
          style: j24,
        ),
      ),
      body: BlocBuilder<FetchSavedPostBloc, FetchSavedPostState>(
        builder: (context, state) {
          if (state is FetchSavedPostSuccessState) {
            if (state.posts.isNotEmpty) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return SavedPostTile(
                    statesaved: state,
                    mainImage: state.posts[index].postId.image,
                    profileImage: state.posts[index].postId.userId.profilePic,
                    userName: state.posts[index].postId.userId.userName,
                    postTime: state.posts[index].createdAt ==
                            state.posts[index].editedTime
                        ? formatDate(state.posts[index].createdAt.toString())
                        : ("${formatDate(state.posts[index].editedTime.toString())} (Edited)"),
                    description: state.posts[index].postId.description,
                    tags: state.posts[index].postId.tags,
                    likeCount:
                        state.posts[index].postId.likes.length.toString(),
                    commentCount: '',
                    likeButtonPressed: () {},
                    removeSaved: () async {
                      context.read<SavePostBloc>().add(UnSaveButtonClickedEvent(
                          postId: state.posts[index].postId.id));
                      context
                          .read<FetchSavedPostBloc>()
                          .add(SavedPostsInitialFetchEvent());
                    },
                    commentButtonPressed: () {
                      context.read<FetchAllCommentsBloc>().add(
                          CommentsFetchEvent(
                              postId: state.posts[index].postId.id.toString()));
                      commentBottomSheet(
                          context, state.posts[index].postId, commentController,
                          formKey: _formKey,
                          comments: _comments,
                          id: state.posts[index].postId.id.toString());
                    },
                    index: index,
                  );
                },
              );
            } else {
              return const Center(child: Text('No saved posts available.'));
            }
          } else if (state is FetchSavedPostLoadingState) {
            return shimmerTile(); // Show shimmer while loading
          } else if (state is FetchSavedPostErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error loading saved posts.'),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      context
                          .read<FetchSavedPostBloc>()
                          .add(SavedPostsInitialFetchEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          // Fallback for unhandled states
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
