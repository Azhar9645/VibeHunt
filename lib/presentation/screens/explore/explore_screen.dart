import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/presentation/screens/explore/components/secondary_search_field.dart';
import 'package:vibehunt/presentation/screens/explore/debouncer/debouncer.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/search_all_users/search_all_users_bloc.dart';

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

  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZcaNJcoE9hJ20j1K8H7Ml6872NyPN5zaJjQ&s',
    // Other image URLs...
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
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
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    searchController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Image Slider
              SizedBox(
                height: 400,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ),
              // Search Field
              Positioned(
                top: 40,
                left: 16,
                right: isSearching ? 60 : 16,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
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
                    },
                  ),
                ),
              ),
              // Close Button
              if (isSearching)
                Positioned(
                  top: 40,
                  right: 16,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                      });
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 30),
          // Use BlocBuilder to listen for state changes
          Expanded(
            child: isSearching
                ? BlocBuilder<SearchAllUsersBloc, SearchAllUsersState>(
                    builder: (context, state) {
                      if (state is SearchAllUsersLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is SearchAllUsersSuccessState) {
                        final users = state.users;
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(users[index]
                                        .profilePic ??
                                    'https://randomuser.me/api/portraits/men/1.jpg'), // Replace with user profile picture
                              ),
                              title: Text(users[index].name ??
                                  'No Name'), // Replace with user name property
                            );
                          },
                        );
                      } else if (state is SearchAllUsersErrorState) {
                        return Center(child: Text('Error loading users'));
                      }
                      return Center(child: Text('Search for users...'));
                    },
                  )
                : buildDefaultView(),
          ),
        ],
      ),
    );
  }

  Widget buildDefaultView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children:
          images.map((imageUrl) => _buildThumbnailCard(imageUrl)).toList(),
    );
  }

  Widget _buildThumbnailCard(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 335,
            child: Stack(
              children: [
                Container(
                  width: 150,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Positioned(
                  top: 260,
                  left: 16,
                  right: 16,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
