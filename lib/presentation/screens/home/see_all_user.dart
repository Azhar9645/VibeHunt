import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/all_user_model.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class SeeAllUsersPage extends StatefulWidget {
  final List<AllUser> users;

  const SeeAllUsersPage({Key? key, required this.users}) : super(key: key);

  @override
  _SeeAllUsersPageState createState() => _SeeAllUsersPageState();
}

class _SeeAllUsersPageState extends State<SeeAllUsersPage> {
  late List<AllUser> sortedUsers;
  late List<bool> isFollowingList;

  @override
  void initState() {
    super.initState();
    // Track follow/unfollow status for each user
    isFollowingList = List.generate(widget.users.length, (_) => false);
    // Sort users at the beginning
    sortedUsers = List.from(widget.users);
  }

  void _sortUsers() {
    // Sort users: Unfollowed users at the top, followed users at the bottom
    sortedUsers.sort((a, b) {
      bool isAFollowed = isFollowingList[widget.users.indexOf(a)];
      bool isBFollowed = isFollowingList[widget.users.indexOf(b)];
      return isAFollowed == isBFollowed ? 0 : (isAFollowed ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users', style: j24),
      ),
      body: ListView.builder(
        itemCount: sortedUsers.length,
        itemBuilder: (context, index) {
          final user = sortedUsers[index];
          return BlocProvider(
            create: (context) => FollowUnfollowBloc(),
            child: BlocConsumer<FollowUnfollowBloc, FollowUnfollowState>(
              listener: (context, state) {
                if (state is FollowUserSuccessState) {
                  setState(() {
                    isFollowingList[widget.users.indexOf(user)] = true;
                    _sortUsers();
                  });
                } else if (state is UnFollowUserSuccessState) {
                  setState(() {
                    isFollowingList[widget.users.indexOf(user)] = false;
                    _sortUsers();
                  });
                }
              },
              builder: (context, state) {
                bool isFollowing = isFollowingList[widget.users.indexOf(user)];

                return _buildUserListItem(
                  context: context,
                  profileImageUrl: user.profilePic,
                  username: user.userName,
                  isFollowing: isFollowing,
                  onFollowPressed: () {
                    if (isFollowing) {
                      context.read<FollowUnfollowBloc>().add(
                          OnUnFollowButtonClickedEvent(followerId: user.id));
                    } else {
                      context.read<FollowUnfollowBloc>().add(
                          OnFollowButtonClickedEvent(followerId: user.id));
                    }
                  },
                  isLoading: state is FollowUserLoadingState ||
                      state is UnFollowUserLoadingState,
                );
              },
            ),
          );
        },
      ),
    );
  }

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