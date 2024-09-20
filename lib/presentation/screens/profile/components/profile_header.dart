import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/presentation/screens/profile/components/edit_profile.dart';
import 'package:vibehunt/presentation/screens/profile/components/profile_bottom_sheet.dart';
import 'package:vibehunt/presentation/widgets/custom_outline_button.dart';
import 'package:vibehunt/utils/constants.dart';

class ProfileHeader extends StatelessWidget {
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;

  const ProfileHeader({
    super.key,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
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
            Positioned(
              bottom: -58.r, // Adjusted for better fit
              left: MediaQuery.of(context).size.width / 2 - 64.r,
              child: CircleAvatar(
                radius: 68.r,
                backgroundColor: kGrey,
              ),
            ),
            Positioned(
              bottom: -48.r, // Adjusted for better fit
              left: MediaQuery.of(context).size.width / 2 - 56.r,
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: NetworkImage(profileImage),
              ),
            ),
            // Saved section
            Positioned(
              bottom: -20.r, // Adjusted to fit within view
              left: MediaQuery.of(context).size.width / 2 - 150.r,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text('321K', style: j20),
                  Text('Followers', style: jStyleW),
                ],
              ),
            ),
            // Liked section
            Positioned(
              bottom: -20.r, // Adjusted to fit within view
              right: MediaQuery.of(context).size.width / 2 - 155.r,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text('125', style: j20),
                  Text('Following', style: jStyleW),
                ],
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
              text: 'message',
              onTap: () {},
            )
          ],
        ),
      ],
    );
  }
}
