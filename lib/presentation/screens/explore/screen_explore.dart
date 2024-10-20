import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/following_post_model.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/data/models/saved_post_model.dart';
import 'package:vibehunt/presentation/screens/home/widgets/post_tile.dart';
import 'package:vibehunt/presentation/screens/home/widgets/shimmer_post_tile.dart';
import 'package:vibehunt/presentation/screens/profile/components/bottomsheets/comment_bottomsheet.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_following_post/fetch_all_following_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class ScreenExplore extends StatefulWidget {
  const ScreenExplore({super.key});

  @override
  State<ScreenExplore> createState() => _ScreenExploreState();
}

class _ScreenExploreState extends State<ScreenExplore> {
  TextEditingController commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<Comment> _comments = [];
  List<SavedPostModel> savedposts = [];
  final ScrollController _scrollController = ScrollController();
  List<FollowingPostModel> _posts = [];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
    _scrollController.addListener(_onScroll);
  }

  void _fetchInitialData() {
    context
        .read<FetchAllFollowingPostBloc>()
        .add(AllFollowingsPostsInitialFetchEvent());
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !context.read<FetchAllFollowingPostBloc>().isLoadingMore) {
      context.read<FetchAllFollowingPostBloc>().add(LoadMoreEvent());
    }
  }

  Future<void> _onRefresh() async {
    context
        .read<FetchAllFollowingPostBloc>()
        .add(AllFollowingsPostsInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Explore", style: j24),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPostsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<FetchAllFollowingPostBloc, FetchAllFollowingPostState>(
        builder: (context, state) {
          if (state is FetchAllFollowingPostLoading) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ShimmerPostTile();
              },
            );
          } else if (state is FetchAllFollowingPostSuccess) {
            _posts = state.posts;
            _isLoadingMore = false;
            return _buildPostsListView(_posts);
          } else if (state is FetchMorePostSuccessState) {
            _posts = [..._posts, ...state.posts];
            _isLoadingMore = false;
            return _buildPostsListView(_posts);
          } else if (state is FetchAllFollowingPostErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.error}'),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: _onRefresh,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No posts available.'));
        },
      ),
    );
  }

  Widget _buildPostsListView(List<FollowingPostModel> posts) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return buildPostTile(
          context: context,
          model: posts[index],
          commentController: commentController,
          formKey: _formKey,
          comments: _comments,
          savedposts: savedposts,
          onCommentTap: () {
            context
                .read<FetchAllCommentsBloc>()
                .add(CommentsFetchEvent(postId: posts[index].id.toString()));
            commentBottomSheet(
              context,
              posts[index],
              commentController,
              formKey: _formKey,
              comments: _comments,
              id: posts[index].id.toString(),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
