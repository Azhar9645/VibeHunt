import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/presentation/screens/profile/components/edit_profile.dart';
import 'package:vibehunt/presentation/screens/profile/components/bottomsheets/profile_bottom_sheet.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/followers_screen.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/following_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followings_bloc/fetchfollowing_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_outline_button.dart';
import 'package:vibehunt/utils/constants.dart';

class ProfileHeader extends StatelessWidget {
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  const ProfileHeader({
    super.key,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.onFollowersTap,
    required this.onFollowingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Cover Image
            Container(
              width: double.infinity,
              height: 190.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(coverImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Menu Icon
            Positioned(
              top: 20.h,
              right: 20.w,
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 35.sp),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return const ProfileOptionsBottomSheet();
                    },
                  );
                },
              ),
            ),
            // Profile Container Background
            Positioned(
              bottom: -50.r, // Adjusted for better fit
              left: MediaQuery.of(context).size.width / 2 - 175.r,
              child: Container(
                width: 350.r,
                height: 110.r,
                decoration: BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
            ),
            // Profile Image Background
            Positioned(
              bottom: -58.r, // Adjusted for better fit
              left: MediaQuery.of(context).size.width / 2 - 64.r,
              child: CircleAvatar(
                radius: 68.r,
                backgroundColor: kGrey,
              ),
            ),
            // Profile Image
            Positioned(
              bottom: -48.r, // Adjusted for better fit
              left: MediaQuery.of(context).size.width / 2 - 56.r,
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: NetworkImage(profileImage),
              ),
            ),
            // Followers Section
            Positioned(
              bottom: -20.r, // Adjusted to fit within view
              left: MediaQuery.of(context).size.width / 2 - 150.r,
              child: GestureDetector(
                onTap: onFollowersTap,
                child: Column(
                  children: [
                    BlocBuilder<FetchfollowersBloc, FetchfollowersState>(
                      builder: (context, state) {
                        if (state is FetchfollowersLoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is FetchfollowersSuccessState) {
                          return Column(
                            children: [
                              Text(
                                  state.followersModel.followers.length
                                      .toString(),
                                  style: j20),
                              Text('Followers', style: jStyleW),
                            ],
                          );
                        } else if (state is FetchfollowersErrorState) {
                          return Text('Error', style: j20);
                        } else {
                          return Text('0', style: j20);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Following Section
            Positioned(
              bottom: -20.r, // Adjusted to fit within view
              right: MediaQuery.of(context).size.width / 2 - 155.r,
              child: GestureDetector(
                onTap: onFollowingTap,
                child: Column(
                  children: [
                    BlocBuilder<FetchfollowingBloc, FetchfollowingState>(
                      builder: (context, state) {
                        if (state is FetchfollowingLoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is FetchfollowingSuccessState) {
                          return Column(
                            children: [
                              Text(state.following.following.length.toString(),
                                  style: j20),
                              Text('Following', style: jStyleW),
                            ],
                          );
                        } else if (state is FetchfollowingErrorState) {
                          return Text('Error', style: j20);
                        } else {
                          return Text('0', style: j20);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 65.h),
        Text(userName, style: j24),
        Text(bio),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomOutlineButton(
              text: 'Edit Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ScreenEditProfile(
                      cvImage: coverImage,
                      prImage: profileImage,
                    ),
                  ),
                );
              },
            ),
            CustomOutlineButton(
              text: 'Message',
              onTap: () {},
            )
          ],
        ),
      ],
    );
  }
}
