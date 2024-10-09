import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_screen.dart';
import 'package:vibehunt/presentation/screens/profile/widgets/shimmertile.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followings_bloc/fetchfollowing_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/utils/constants.dart';

class ScreenFollowing extends StatelessWidget {
  const ScreenFollowing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Following', style: j24),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FetchfollowingBloc, FetchfollowingState>(
            listener: (context, state) {
              if (state is FetchfollowingErrorState) {
                customSnackbar(context, 'Failed..!', kRed, Icons.sms_failed);
              }
            },
          ),
          BlocListener<FollowUnfollowBloc, FollowUnfollowState>(
            listener: (context, state) {
              if (state is UnFollowUserSuccessState) {
                context.read<FetchfollowingBloc>().add(OnFetchFollowingUsersEvent());
              } else if (state is UnFollowUserErrorState) {
                customSnackbar(context, 'Unfollow failed!', kRed, Icons.error);
              }
            },
          ),
        ],
        child: BlocBuilder<FetchfollowingBloc, FetchfollowingState>(
          builder: (context, state) {
            if (state is FetchfollowingLoadingState || state is UnFollowUserLoadingState) {
              return ListView.builder(
                itemBuilder: (context, index) => shimmerTile(),
                itemCount: 5,
              );
            } else if (state is FetchfollowingSuccessState) {
              final followings = state.following.following;

              if (followings.isEmpty) {
                return const Center(
                  child: Text('No followers yet.', style: TextStyle(color: Colors.white)),
                );
              }

              return ListView.builder(
                itemCount: followings.length,
                itemBuilder: (context, index) {
                  final followingUser = followings[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(
                              userId: followingUser.id,
                              user: UserIdSearchModel(
                                id: followingUser.id,
                                userName: followingUser.userName,
                                email: followingUser.email,
                                profilePic: followingUser.profilePic,
                                online: followingUser.online,
                                blocked: followingUser.blocked,
                                verified: followingUser.verified,
                                role: followingUser.role,
                                isPrivate: followingUser.isPrivate,
                                backGroundImage: followingUser.backGroundImage,
                                createdAt: DateTime.parse(followingUser.createdAt),
                                updatedAt: DateTime.parse(followingUser.updatedAt),
                                v: followingUser.v,
                                bio: followingUser.bio ?? '',
                              ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[600],
                            backgroundImage: NetworkImage(followingUser.profilePic),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  followingUser.userName,
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
                            onPressed: () {
                              context.read<FollowUnfollowBloc>().add(
                                OnUnFollowButtonClickedEvent(followerId: followingUser.id),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Unfollow',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: kGreen,
                  size: 30,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
