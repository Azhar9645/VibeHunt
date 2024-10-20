import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vibehunt/presentation/screens/explore/components/secondary_search_field.dart';
import 'package:vibehunt/presentation/screens/explore/debouncer/debouncer.dart';
import 'package:vibehunt/presentation/screens/explore/screen_explore.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/explore_post/explore_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_following_post/fetch_all_following_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_users/get_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/search_all_users/search_all_users_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 700);
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<ExplorePostBloc>().add(OnFetchExplorePostsEvent());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _startAutoSlideTimer(int postLength) {
    _timer?.cancel(); // Ensure no multiple timers are running

    // Timer for auto-sliding the PageView
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < postLength - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: isSearching
                          ? _buildSearchResults()
                          : BlocBuilder<ExplorePostBloc, ExplorePostState>(
                              builder: (context, state) {
                                if (state is ExplorePostLoadingState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is ExplorePostSuccessState) {
                                  if (state.posts.isNotEmpty) {
                                    // Start the timer after posts are fetched successfully
                                    _startAutoSlideTimer(state.posts.length);

                                    return PageView.builder(
                                      controller: _pageController,
                                      itemCount: state.posts.length,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentPage = index;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        return Image.network(
                                          state.posts[index].image,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: Text('No images available.'));
                                  }
                                } else if (state is ExplorePostErrorState) {
                                  return const Center(
                                      child: Text('Failed to load images.'));
                                }
                                return const Center(
                                    child: Text('No images available.'));
                              },
                            ),
                    ),
                    const SizedBox(height: 16),
                    // Dots Indicator below the slider
                    BlocBuilder<ExplorePostBloc, ExplorePostState>(
                      builder: (context, state) {
                        if (state is ExplorePostSuccessState) {
                          return SmoothPageIndicator(
                            controller: _pageController, // PageController
                            count: 6, // Use posts count
                            effect: const ExpandingDotsEffect(
                              activeDotColor: kGreen,
                              dotColor: Colors.grey,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 6,
                            ),
                          );
                        }
                        return const SizedBox
                            .shrink(); // Hide the indicator if no posts
                      },
                    ),
                  ],
                ),
                // Search Field
                Positioned(
                  top: 40,
                  left: 16,
                  right: isSearching ? 60 : 16,
                  child: SecondarySearchField(
                    controller: searchController,
                    onTextChanged: (String value) {
                      if (value.isNotEmpty) {
                        _debouncer.run(() {
                          context
                              .read<SearchAllUsersBloc>()
                              .add(OnSearchAllUsersEvent(query: value));
                        });
                      }
                    },
                    onTap: () {
                      setState(() {
                        isSearching = true;
                      });
                      context
                          .read<GetAllUsersBloc>()
                          .add(FetchGetAllUsersEvent());
                    },
                  ),
                ),
                // Positioned(
                //   top: 200,
                //   left: 16,
                //   right: isSearching ? 60 : 16,
                //   child: Text(
                //     '"Creativity is intelligence having fun." \n- Albert Einstein',
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //       shadows: [
                //         Shadow(
                //           blurRadius: 10,
                //           color: Colors.black.withOpacity(0.5),
                //           offset: Offset(2, 2),
                //         ),
                //       ],
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                // Close Button
                if (isSearching)
                  Positioned(
                    top: 40,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                          searchController.clear();
                        });
                        context
                            .read<GetAllUsersBloc>()
                            .add(FetchGetAllUsersEvent());
                      },
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'ideas from creators',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 400,
              child: isSearching ? _buildSearchResults() : buildDefaultView(),
            ),
          ],
        ),
      ),
    );
  }

  // Search Results ListView
  Widget _buildSearchResults() {
    return BlocBuilder<GetAllUsersBloc, GetAllUsersState>(
      builder: (context, state) {
        if (state is GetAllUsersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllUsersSuccessState) {
          final users = state.users;
          if (users.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 100),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic ??
                        'https://randomuser.me/api/portraits/men/1.jpg'),
                  ),
                  title: Text(user.name ?? 'No Name'),
                  subtitle: Text(user.email ?? 'No Email'),
                ),
              );
            },
          );
        } else if (state is GetAllUsersErrorState) {
          return const Center(child: Text('Error loading users.'));
        }

        return const Center(child: Text('No users available.'));
      },
    );
  }

  // Default view when not searching: a list of thumbnail cards
  Widget buildDefaultView() {
    return BlocBuilder<FetchAllFollowingPostBloc, FetchAllFollowingPostState>(
      builder: (context, state) {
        if (state is FetchAllFollowingPostLoading) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const CircularProgressIndicator();
            },
          );
        } else if (state is FetchAllFollowingPostSuccess) {
          final posts = state.posts;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return _buildThumbnailCard(post.image, post.userId.profilePic);
            },
          );
        } else if (state is FetchAllFollowingPostErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
        return const Center(child: Text('No posts available.'));
      },
    );
  }

  Widget _buildThumbnailCard(String? imageUrl, String? profilePictureUrl) {
    final defaultImageUrl = 'https://via.placeholder.com/150';
    final defaultProfilePictureUrl = 'https://via.placeholder.com/100';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenExplore(),
                  ));
            },
            child: SizedBox(
              height: 320,
              child: Stack(
                children: [
                  // Post image
                  Container(
                    width: 150,
                    height: 260,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl ?? defaultImageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Profile image on the post
                  Positioned(
                    top: 220,
                    left: 16,
                    right: 16,
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage: NetworkImage(
                          profilePictureUrl ?? defaultProfilePictureUrl),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
