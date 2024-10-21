import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vibehunt/presentation/screens/explore/components/secondary_search_field.dart';
import 'package:vibehunt/presentation/screens/explore/debouncer/debouncer.dart';
import 'package:vibehunt/presentation/screens/explore/screen_explore.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_screen.dart';
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
  String onchangevalue = '';

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

  // void _startAutoSlideTimer(int postLength) {
  //   _timer?.cancel();

  //   _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
  //     if (_currentPage < postLength - 1) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }
  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: const Duration(milliseconds: 350),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }
  void _startAutoSlideTimer(int postLength) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        // Check if the PageController has clients
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isSearching ? _buildSearchResults() : _buildDefaultStack(context),
          // Search Field (visible in both states)
          Positioned(
            top: 40,
            left: 16,
            right: isSearching ? 60 : 16,
            child: SecondarySearchField(
              controller: searchController,
              onTextChanged: (String value) {
                setState(() {
                  isSearching = true; // Switch to searching mode immediately
                  onchangevalue = value;
                });
                if (value.isNotEmpty) {
                  _debouncer.run(() {
                    context
                        .read<SearchAllUsersBloc>()
                        .add(OnSearchAllUsersEvent(query: value));
                  });
                } else {
                  setState(() {
                    isSearching =
                        false; // If no input, return to non-search mode
                  });
                }
              },
              onTap: () {
                setState(() {
                  isSearching = true;
                });
                // context.read<GetAllUsersBloc>().add(FetchGetAllUsersEvent());
              },
            ),
          ),
          // Close Button (visible only when searching)
          if (isSearching)
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: kWhiteColor),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    searchController.clear();
                  });
                  context.read<GetAllUsersBloc>().add(FetchGetAllUsersEvent());
                },
              ),
            ),
        ],
      ),
    );
  }

  Stack _buildDefaultStack(BuildContext context) {
    return Stack(
      children: [
        // Image Slider
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 400,
            child: BlocBuilder<ExplorePostBloc, ExplorePostState>(
              builder: (context, state) {
                if (state is ExplorePostLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ExplorePostSuccessState) {
                  if (state.posts.isNotEmpty) {
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
                    return const Center(child: Text('No images available.'));
                  }
                } else if (state is ExplorePostErrorState) {
                  return const Center(child: Text('Failed to load images.'));
                }
                return const Center(child: Text('No images available.'));
              },
            ),
          ),
        ),
        // Dots Indicator
        Positioned(
          top: 415,
          left: 0,
          right: 0,
          child: BlocBuilder<ExplorePostBloc, ExplorePostState>(
            builder: (context, state) {
              if (state is ExplorePostSuccessState) {
                return Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 6,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: kGreen,
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        // Text below the Dots Indicator
        const Positioned(
          top: 440,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Ideas from creators',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        // Thumbnail Cards below the Text
        Positioned(
          top: 475,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 400,
            child: buildDefaultView(),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<SearchAllUsersBloc, SearchAllUsersState>(
      builder: (context, state) {
        if (state is SearchAllUsersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchAllUsersSuccessState) {
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
                    radius: 25,
                    backgroundImage: NetworkImage(user.profilePic ??
                        'https://randomuser.me/api/portraits/men/1.jpg'),
                  ),
                  title: Text(
                    user.name ?? 'No Name',
                    style: j20,
                  ),
                  subtitle:
                      Text('_${user.name ?? 'User'}_${user.name ?? 'User'}_'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                              userId: state.users[index].id.toString(),
                              user: state.users[index]),
                        ));
                  },
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
                      backgroundColor: Colors.transparent,
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
