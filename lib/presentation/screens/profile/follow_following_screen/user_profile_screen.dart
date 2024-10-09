import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_header.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profiletab_views.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followings_bloc/fetchfollowing_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_users_post/fetch_users_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_user_details_bloc/signin_user_details_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/user_connection_count/user_connection_count_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  final UserIdSearchModel user;

  const UserProfileScreen({
    super.key,
    required this.userId,
    required this.user,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String posts = '';

  @override
  void initState() {
    super.initState();

    context
        .read<FetchUsersPostBloc>()
        .add(UsersInitialPostFetchEvent(userId: widget.userId));
    context
        .read<UserConnectionCountBloc>()
        .add(UserConnectionsInitilFetchEvent(userId: widget.userId));
    context.read<FetchfollowingBloc>().add(OnFetchFollowingUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocBuilder(
      blocs: [
        context.watch<SigninUserDetailsBloc>(),
        context.watch<FetchUsersPostBloc>(),
        context.watch<FetchfollowingBloc>(),
        context.watch<UserConnectionCountBloc>(),
        context.watch<FollowUnfollowBloc>(),
      ],
      builder: (context, state) {
        var state2 = state[1];
        if (state2 is FetchUsersPostSuccessState) {
          posts = state2.posts.length.toString();
        }

        bool isFollowing = false; // Track follow status

        // Check if the user is already followed
        final followingsState = context.watch<FetchfollowingBloc>().state;
        if (followingsState is FetchfollowingSuccessState) {
          isFollowing = followingsState.following.following
              .any((user) => user.id == widget.userId);
        }
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 350.h,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.symmetric(horizontal: 20),
                  background: UserProfileHeader(
                    user: widget.user,
                    profileImage: widget.user.profilePic,
                    coverImage: widget.user.backGroundImage,
                    userName: widget.user.userName,
                    bio: widget.user.bio,
                    onFollowersTap: () {},
                    onFollowingTap: () {},
                    onPostsTap: () {},
                    isFollowing: isFollowing, // Pass follow status
                  ),
                ),
              ),
            ];
          },
          body: UsersProfileTabViews(),
        );
      },
    ));
  }
}
