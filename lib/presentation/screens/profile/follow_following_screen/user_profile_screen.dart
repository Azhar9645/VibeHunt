import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_header.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profiletab_views.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_users_post/fetch_users_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/user_connection_count/user_connection_count_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.userId,
    required this.user,
  });

  final String userId;
  final UserIdSearchModel user;

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
    context.read<FetchfollowersBloc>().add(OnfetchAllFollowersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
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
              ),
            ),
          ),
        ];
      },
      body: UserProfileTabViews(),
    ));
  }
}
