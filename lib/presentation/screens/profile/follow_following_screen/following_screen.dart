import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followings_bloc/fetchfollowing_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Following', style: j24),
      ),
      body: BlocBuilder<FetchfollowingBloc, FetchfollowingState>(
        builder: (context, state) {
          if (state is FetchfollowingLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchfollowingSuccessState) {
            return ListView.builder(
              itemCount: state.following.following.length,
              itemBuilder: (context, index) {
                final following = state.following.following[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(following.profilePic), // Replace with the actual profile image property
                  ),
                  title: Text(following.userName), // Replace with the actual username property
                  onTap: () {
                    // Navigate to the followed person's profile
                  },
                );
              },
            );
          } else if (state is FetchfollowingErrorState) {
            return Center(child: Text('Error fetching followings'));
          } else {
            return Center(child: Text('Not following anyone'));
          }
        },
      ),
    );
  }
}
