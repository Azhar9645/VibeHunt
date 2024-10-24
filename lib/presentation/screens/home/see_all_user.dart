import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/all_user_model.dart';
import 'package:vibehunt/presentation/screens/rive_screen.dart/rive_loading.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_users/fetch_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class SeeAllUsersPage extends StatefulWidget {
  const SeeAllUsersPage({Key? key}) : super(key: key);

  @override
  _SeeAllUsersPageState createState() => _SeeAllUsersPageState();
}

class _SeeAllUsersPageState extends State<SeeAllUsersPage> {
  List<AllUser> allUsers = [];
  late List<AllUser> sortedUsers;
  List<bool> isFollowingList = [];
  int currentPage = 1;
  final int pageLimit = 10;

  @override
  void initState() {
    super.initState();
    // Initialize following status for each user
    isFollowingList = List.generate(allUsers.length, (_) => false);
    // Sort users initially
    sortedUsers = List.from(allUsers);
  }

  // Sorting logic to move followed users to the bottom
  void _sortUsers() {
    sortedUsers.sort((a, b) {
      bool isAFollowed = isFollowingList[allUsers.indexOf(a)];
      bool isBFollowed = isFollowingList[allUsers.indexOf(b)];
      return isAFollowed == isBFollowed ? 0 : (isAFollowed ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users', style: j24),
      ),
      body: BlocProvider(
        create: (context) => FetchAllUsersBloc()
          ..add(OnFetchAllUserEvent(page: currentPage, limit: pageLimit)),
        child: BlocConsumer<FetchAllUsersBloc, FetchAllUsersState>(
          listener: (context, state) {
            if (state is FetchAllUsersSuccessState) {
              setState(() {
                allUsers.addAll(state.users);
                isFollowingList.addAll(List.generate(state.users.length, (_) => false));
                _sortUsers(); // Sort after fetching new users
              });
            }
          },
          builder: (context, state) {
            if (state is FetchAllUsersLoadingState && allUsers.isEmpty) {
              return RiveLoadingScreen();
            } else if (state is FetchAllUsersErrorState) {
              return Center(child: Text(state.error));
            } else {
              return ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  final user = allUsers[index];
                  return BlocProvider(
                    create: (context) => FollowUnfollowBloc(),
                    child: BlocConsumer<FollowUnfollowBloc, FollowUnfollowState>(
                      listener: (context, followState) {
                        if (followState is FollowUserSuccessState) {
                          setState(() {
                            isFollowingList[allUsers.indexOf(user)] = true;
                            _sortUsers(); // Move followed user to the bottom
                          });
                        } else if (followState is UnFollowUserSuccessState) {
                          setState(() {
                            isFollowingList[allUsers.indexOf(user)] = false;
                            _sortUsers(); // Move unfollowed user back up
                          });
                        }
                      },
                      builder: (context, followState) {
                        bool isFollowing = isFollowingList[allUsers.indexOf(user)];
                        return _buildUserListItem(
                          context: context,
                          profileImageUrl: user.profilePic!,
                          username: user.userName,
                          isFollowing: isFollowing,
                          onFollowPressed: () {
                            if (isFollowing) {
                              context.read<FollowUnfollowBloc>().add(
                                  OnUnFollowButtonClickedEvent(
                                      followerId: user.id));
                            } else {
                              context.read<FollowUnfollowBloc>().add(
                                  OnFollowButtonClickedEvent(
                                      followerId: user.id));
                            }
                          },
                          isLoading: followState is FollowUserLoadingState ||
                              followState is UnFollowUserLoadingState,
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Widget to build each user item in the list
  Widget _buildUserListItem({
    required BuildContext context,
    required String profileImageUrl,
    required String username,
    required bool isFollowing,
    required VoidCallback onFollowPressed,
    required bool isLoading,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey[600],
            backgroundImage: NetworkImage(profileImageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isLoading ? null : onFollowPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? Colors.grey : kGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    isFollowing ? 'Following' : 'Follow',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
