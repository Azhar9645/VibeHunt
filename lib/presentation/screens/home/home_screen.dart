import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vibehunt/presentation/screens/home/see_all_user.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_users/fetch_all_users_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

String logginedUserToken = '';
String logginedUserId = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZcaNJcoE9hJ20j1K8H7Ml6872NyPN5zaJjQ&s',
    'https://images.unsplash.com/photo-1472396961693-142e6e269027?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bmF0dXJlfGVufDB8fDB8fHwy',
    'https://images.unsplash.com/photo-1615729947596-a598e5de0ab3?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fG5hdHVyZXxlbnwwfHwwfHx8Mg%3D%3D',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=80&w=2948&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1540206395-68808572332f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzV8fG5hdHVyZXxlbnwwfHwwfHx8Mg%3D%3D',
    'https://images.unsplash.com/photo-1586348943529-beaae6c28db9?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fG5hdHVyZXxlbnwwfHwwfHx8Mg%3D%3D'
  ];

  final List<String> keywords = [
    'Mountain Art',
    'Sunset',
    'Forest',
    'Mountain',
    'Beach',
    'Sunny River',
  ];

  @override
  void initState() {
    super.initState();
    context
        .read<FetchAllUsersBloc>()
        .add(OnFetchAllUserEvent(page: 1, limit: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSeeAllAndStorySection(context),
                    _buildMasonryGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Hi, AZHAR', style: j24),
        IconButton(
          icon: const Icon(
            Icons.notifications_active_outlined,
            color: kWhiteColor,
            size: 35,
          ),
          onPressed: () {
            // Action for notification icon
          },
        ),
      ],
    );
  }

  Widget _buildSeeAllAndStorySection(BuildContext context) {
    return BlocBuilder<FetchAllUsersBloc, FetchAllUsersState>(
      builder: (context, state) {
        if (state is FetchAllUsersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchAllUsersSuccessState) {
          final users = state.users;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to the 'See All' page and pass the list of users
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeAllUsersPage(users: users),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: kGreen, // Customize the button color
                          ),
                        ),
                        SizedBox(
                            width:
                                4), // Add space between the text and the icon
                        Icon(
                          Icons.arrow_forward_ios, // Customize the icon
                          color: kGreen, // Customize the icon color
                          size: 16, // Customize the size
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 100, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                            width:
                                80, // Slightly larger to accommodate the border
                            height:
                                80, // Slightly larger to accommodate the border
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kGreen, // Border color
                                width: 2.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                users[index]
                                    .profilePic, // Use user profile picture
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            users[index].userName, // Use user name
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is FetchAllUsersErrorState) {
          return Center(child: Text('Failed to load users: ${state.error}'));
        } else {
          return const Center(child: Text('No users available.'));
        }
      },
    );
  }

  // Widget _buildSeeAllRow() {
  //   return TextButton(
  //     onPressed: () {
  //       // Define action for "See All" button here
  //     },
  //     child: const Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Text(
  //           'See All',
  //           style: TextStyle(color: kGreen),
  //         ),
  //         SizedBox(width: 4),
  //         Icon(
  //           Icons.arrow_forward_ios,
  //           color: kGreen,
  //           size: 16,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildStorySection() {
  //   return SizedBox(
  //     height: 100,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: storyImages.length,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Column(
  //             children: [
  //               _buildStoryCircle(storyImages[index]),
  //               const SizedBox(height: 2),
  //               Text(
  //                 storyNames[index],
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildStoryCircle(String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: kGreen, width: 2.0),
        borderRadius: BorderRadius.circular(22),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMasonryGrid() {
    return MasonryGridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildMasonryTile(images[index], keywords[index]);
      },
    );
  }

  Widget _buildMasonryTile(String imageUrl, String keyword) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
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
          const SizedBox(height: 4.0),
          Text(
            keyword,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
