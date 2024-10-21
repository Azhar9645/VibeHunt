import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/all_user_model.dart';
import 'package:vibehunt/data/models/get_all_users_model.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/screens/home/see_all_user.dart';
import 'package:vibehunt/presentation/screens/home/widgets/Shimmer_user_avatars.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_all_users/fetch_all_users_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_users/get_all_users_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

Widget buildSeeAllAndStorySection(BuildContext context) {
  return BlocBuilder<FetchAllUsersBloc, FetchAllUsersState>(
    builder: (context, state) {
      if (state is FetchAllUsersLoadingState) {
        return const ShimmerUserAvatars(isLoading: true);
      } else if (state is FetchAllUsersSuccessState) {
        return buildUsersList(context, state.users);
      } else if (state is FetchAllUsersErrorState) {
        return Center(child: Text('Failed to load users: ${state.error}'));
      } else {
        return const Center(child: Text('No users available.'));
      }
    },
  );
}

Widget buildUsersList(BuildContext context, List<AllUser> users) {
  return Column(
    children: [
      buildSeeAllButton(context, users),
      const SizedBox(height: 5),
      buildUserAvatars(), // Updated to use the new buildUserAvatars function
    ],
  );
}

Widget buildSeeAllButton(BuildContext context, List<AllUser> users) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeeAllUsersPage(users: users)),
          );
        },
        child: const Row(
          children: [
            Text('See All', style: TextStyle(color: kGreen)),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, color: kGreen, size: 16),
          ],
        ),
      ),
    ],
  );
}

Widget buildUserAvatars() {
  return BlocProvider(
    create: (context) => GetAllUsersBloc()..add(FetchGetAllUsersEvent()), // Fetch all users
    child: BlocBuilder<GetAllUsersBloc, GetAllUsersState>(
      builder: (context, state) {
        if (state is GetAllUsersLoadingState) {
          return const ShimmerUserAvatars(isLoading: true);
        } else if (state is GetAllUsersSuccessState) {
          final String signedInUserId = logginedUserId; // Replace with your method to get the signed-in user's ID

          final List<GetAllUsersModel> filteredUsers = state.users
              .where((user) => user.id != signedInUserId) // Exclude signed-in user
              .toList();

          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: kGreen, width: 2.0),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            user.profilePic,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.userName,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is GetAllUsersErrorState) {
          return const Center(child: Text('Failed to load users.'));
        } else {
          return const Center(child: Text('No users available.'));
        }
      },
    ),
  );
}
