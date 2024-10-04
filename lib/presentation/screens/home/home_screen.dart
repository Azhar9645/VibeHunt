import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vibehunt/data/models/all_user_model.dart';
import 'package:vibehunt/data/models/following_post_model.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/data/models/saved_post_model.dart';
import 'package:vibehunt/presentation/screens/home/header_section.dart';
import 'package:vibehunt/presentation/screens/home/see_all_user.dart';
import 'package:vibehunt/presentation/screens/home/story_section.dart';
import 'package:vibehunt/presentation/screens/home/widgets/Shimmer_user_avatars.dart';
import 'package:vibehunt/presentation/screens/home/widgets/post_tile.dart';
import 'package:vibehunt/presentation/screens/home/widgets/shimmer_post_tile.dart';
import 'package:vibehunt/presentation/screens/profile/components/comment_bottomsheet.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_comment_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_like_button.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/custom_save_buttom.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_comments/fetch_all_comments_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_following_post/fetch_all_following_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_users/fetch_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_user_details_bloc/signin_user_details_bloc.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vibehunt/utils/funtions.dart';

String logginedUserToken = '';
String logginedUserId = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController commentControllers = TextEditingController();
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
        .read<FetchAllUsersBloc>()
        .add(OnFetchAllUserEvent(page: 1, limit: 10));
    context.read<SigninUserDetailsBloc>().add(OnSigninUserDataFetchEvent());
    context.read<FetchAllFollowingPostBloc>().add(
        AllFollowingsPostsInitialFetchEvent()); 
    getToken();
  }

  getToken() async {
    logginedUserToken = (await getUsertoken())!;
    logginedUserId = (await getUserId())!;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: buildHeader(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSeeAllAndStorySection(context),
                  _buildPostsList(),
                ],
              ),
            ),
          ),
        ],
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
              itemCount: 5, // Display a few shimmer placeholders
              itemBuilder: (context, index) {
                return const ShimmerPostTile();
              },
            );
          } else if (state is FetchAllFollowingPostSuccess) {
            // Handle successful fetching of all followers' posts
            _posts = state.posts; // Assuming _posts is a class-level variable
            _isLoadingMore = false; // Manage loading state
            return _buildPostsListView(_posts);
          } else if (state is FetchMorePostSuccessState) {
            // Handle loading more posts
            _posts = [..._posts, ...state.posts];
            _isLoadingMore = false; // Manage loading state
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
          commentController: commentControllers,
          formKey: _formKey,
          comments: _comments,
          savedposts:savedposts,
          onCommentTap: () {
            context
                .read<FetchAllCommentsBloc>()
                .add(CommentsFetchEvent(postId: posts[index].id.toString()));
            commentBottomSheet(
              context,
              posts[index],
              commentControllers,
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
