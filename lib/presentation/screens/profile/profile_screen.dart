import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/data/models/sign_in_details.dart';
import 'package:vibehunt/presentation/screens/profile/components/profile_header.dart';
import 'package:vibehunt/presentation/screens/profile/components/profile_tab_views.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/followers_screen.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/following_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followings_bloc/fetchfollowing_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_saved_post/fetch_saved_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_user_details_bloc/signin_user_details_bloc.dart';

String logginedUserProfileImage = '';
String profilepageUserId = '';
String profileuserName = '';
String coverImageUrl = '';
SignInUserModel userdetails = SignInUserModel(
  id: '',
  userName: '',
  email: '',
  phone: '',
  online: true,
  blocked: false,
  verified: false,
  role: '',
  isPrivate: false,
  createdAt: DateTime(20242024 - 06 - 24),
  updatedAt: DateTime(20242024 - 06 - 24),
  profilePic: '',
  backGroundImage: '',
);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    context.read<SigninUserDetailsBloc>().add(OnSigninUserDataFetchEvent());
    context.read<FetchfollowersBloc>().add(OnfetchAllFollowersEvent());
    context.read<FetchfollowingBloc>().add(OnFetchFollowingUsersEvent());
    context.read<FetchSavedPostBloc>().add(SavedPostsInitialFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SigninUserDetailsBloc, SigninUserDetailsState>(
        builder: (context, state) {
          if (state is SigninUserDetailsDataFetchSuccesState) {
            profileuserName = state.userModel.name ?? state.userModel.userName;
            logginedUserProfileImage = state.userModel.profilePic;
            profilepageUserId = state.userModel.id;
            userdetails = state.userModel;
            coverImageUrl = state.userModel.backGroundImage;
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
                    background: ProfileHeader(
                      profileImage: logginedUserProfileImage,
                      coverImage: coverImageUrl,
                      userName: profileuserName,
                      bio: state.userModel.bio ?? '',
                      onFollowersTap: () {
                        if (context.read<FetchfollowersBloc>().state
                            is FetchfollowersSuccessState) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => FollowersScreen(),
                            ),
                          );
                        }
                      },
                      onFollowingTap: () {
                        if (context.read<FetchfollowingBloc>().state
                            is FetchfollowingSuccessState) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const ScreenFollowing(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ];
            },
            body: ProfileTabViews(userName: profileuserName),
          );
        },
      ),
    );
  }
}
