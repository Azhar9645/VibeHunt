import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/all_user_model.dart';
import 'package:vibehunt/data/models/get_all_users_model.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/screens/home/see_all_user.dart';
import 'package:vibehunt/presentation/screens/home/widgets/Shimmer_user_avatars.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_users/get_all_users_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

Widget buildSeeAllAndStorySection(BuildContext context) {
  return Column(
    children: [
      BlocBuilder<GetAllUsersBloc, GetAllUsersState>(
        builder: (context, state) {
          if (state is GetAllUsersLoadingState) {
            return const ShimmerUserAvatars(isLoading: true);
          } else if (state is GetAllUsersSuccessState) {
            return buildUsersList(context, state.users);
          } else if (state is GetAllUsersErrorState) {
            return const Center(child: Text('Failed to load users.'));
          } else {
            return const Center(child: Text('No users available.'));
          }
        },
      ),
    ],
  );
}

Widget buildUsersList(BuildContext context, List<GetAllUsersModel> users) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSeeAllButton(context, users),
      const SizedBox(height: 5),
      buildUserAvatars(
          context, users), // Call buildUserAvatars after the button
    ],
  );
}

Widget buildSeeAllButton(BuildContext context, List<GetAllUsersModel> users) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () {
          // Navigate to See All Users Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SeeAllUsersPage(),
            ),
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

Widget buildUserAvatars(BuildContext context, List<GetAllUsersModel> users) {
  final String signedInUserId =
      logginedUserId; // Replace with your method to get the signed-in user's ID

  final List<GetAllUsersModel> filteredUsers =
      users.where((user) => user.id != signedInUserId).toList();

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
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.red),
                      );
                    },
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
}
