import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vibehunt/presentation/screens/profile/post_details_screen.dart';
import 'package:vibehunt/presentation/screens/rive_screen.dart/rive_loading.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/save_post/save_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class ProfileTabViews extends StatelessWidget {
  final String userName;

  const ProfileTabViews({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarAndTabViews(userName: userName),
    );
  }
}

class TabPair {
  final Tab tab;
  final Widget view;

  TabPair({required this.tab, required this.view});
}

class TabBarAndTabViews extends StatefulWidget {
  final String userName;

  const TabBarAndTabViews({super.key, required this.userName});

  @override
  _TabBarAndTabViewsState createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabPairs.length, vsync: this);
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    context.read<FetchSavedPostBloc>().add(SavedPostsInitialFetchEvent());
  
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                labelColor: kGreen,
                unselectedLabelColor: const Color(0xFF5E5E5E),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                indicatorColor: kGreen,
                indicatorPadding: const EdgeInsets.only(right: 10),
                tabs: tabPairs.map((tabPair) => tabPair.tab).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabPairs.map((tabPair) => tabPair.view).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

final List<TabPair> tabPairs = [
  TabPair(
    tab: const Tab(text: 'Upload'),
    view: const _UploadTabView(),
  ),
  TabPair(
    tab: const Tab(text: 'Saved'),
    view: const _SavedTabView(),
  ),
];

class _UploadTabView extends StatelessWidget {
  const _UploadTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
      builder: (context, state) {
        if (state is FetchMyPostLoadingState) {
          return const Center(
            child: RiveLoadingScreen(),
          );
        } else if (state is FetchMyPostSuccessState) {
          final posts = state.posts;

          if (posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          return MasonryGridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            shrinkWrap: true,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (context.read<FetchMyPostBloc>().state
                            is FetchMyPostSuccessState) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostScreen(
                                index: 0,
                                posts: (context.read<FetchMyPostBloc>().state
                                        as FetchMyPostSuccessState)
                                    .posts,
                              ),
                            ),
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          post.image ?? '', // Assuming post has imageUrl field
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              height: 200,
                              width: double.infinity,
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              );
            },
          );
        } else if (state is FetchMyPostErrorState) {
          return Center(
            child: Text('Failed to load posts: ${state.error}'),
          );
        } else {
          return const Center(child: Text('No posts found'));
        }
      },
    );
  }
}

class _SavedTabView extends StatelessWidget {
  const _SavedTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSavedPostBloc, FetchSavedPostState>(
      builder: (context, state) {
        if (state is FetchSavedPostSuccessState) {
          if (state.posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          return MasonryGridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            shrinkWrap: true,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: state.posts.length, // Display only the single saved post
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          state.posts[index].postId.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              height: 200,
                              width: double.infinity,
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              );
            },
          );
        } else if (state is FetchSavedPostSuccessState) {
          return const Center(child: Text('Post unsaved successfully'));
        } else if (state is FetchSavedPostErrorState ||
            state is FetchSavedPostErrorState) {
          return Center(
            child: const Text('Failed to load posts'),
          );
        } else if (state is FetchSavedPostServerError ||
            state is FetchSavedPostServerError) {
          return const Center(child: Text('Server error occurred'));
        } else {
          return const Center(child: Text('No posts found'));
        }
      },
    );
  }
}
