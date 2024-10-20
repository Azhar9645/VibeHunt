import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/presentation/screens/chat/chat_screen.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_conversation.dart/get_all_conversation_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/user_connection_count/user_connection_count_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_outline_button.dart';
import 'package:vibehunt/utils/constants.dart';

class UserProfileHeader extends StatelessWidget {
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;
  final UserIdSearchModel user;
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;
  final bool isFollowing; // Add this parameter

  const UserProfileHeader({
    super.key,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.onPostsTap,
    required this.onFollowersTap,
    required this.onFollowingTap,
    required this.user,
    required this.isFollowing, // Update constructor
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
                  // showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   builder: (BuildContext context) {
                  //     return const ProfileOptionsBottomSheet();
                  //   },
                  // );
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
                    BlocBuilder<UserConnectionCountBloc,
                        UserConnectionCountState>(
                      builder: (context, state) {
                        if (state is UserConnectionCountLoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is UserConnectionCountSuccessState) {
                          return Column(
                            children: [
                              Text(state.followersCount.toString(), style: j20),
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
                    BlocBuilder<UserConnectionCountBloc,
                        UserConnectionCountState>(
                      builder: (context, state) {
                        if (state is UserConnectionCountLoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is UserConnectionCountSuccessState) {
                          return Column(
                            children: [
                              Text(state.followingsCount.toString(),
                                  style: j20),
                              Text('Following', style: jStyleW),
                            ],
                          );
                        } else if (state is UserConnectionCountErrorState) {
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
              text: isFollowing ? 'Unfollow' : 'Follow',
              onTap: () {},
            ),
            BlocConsumer<ConversationBloc, ConversationState>(
              listener: (context, state) {
                if (state is ConversationSuccesfulState) {
                  context
                      .read<GetAllConversationBloc>()
                      .add(AllConversationsInitialFetchEvent());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            conversationId: state.conversationId,
                            recieverid: user.id,
                            name: user.userName,
                            profilepic: user.profilePic,
                            username: user.userName),
                      ));
                }
              },
              builder: (context, state) {
                return CustomOutlineButton(
                  text: 'Message',
                  onTap: () {
                    context.read<ConversationBloc>().add(
                        CreateConversationButtonClickEvent(
                            members: [logginedUserId, user.id]));
                  },
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
