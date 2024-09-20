import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/edit_user_profile/edit_user_profile_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_user_details_bloc/signin_user_details_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';
import 'dart:io';

import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/utils/funtions.dart';

class ScreenEditProfile extends StatefulWidget {
  const ScreenEditProfile(
      {super.key, required this.cvImage, required this.prImage});
  final String cvImage;
  final String prImage;
  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ValueNotifier<String> profileImageNotifier = ValueNotifier('');
  final ValueNotifier<String> coverImageNotifier = ValueNotifier('');

  String profileImageUrl = '';
  String coverImageUrl = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _ScreenEditProfileState();

  @override
  void initState() {
    super.initState();
    context.read<SigninUserDetailsBloc>().add(OnSigninUserDataFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: j24,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<SigninUserDetailsBloc, SigninUserDetailsState>(
        listener: (context, state) {
          if (state is SigninUserDetailsDataFetchSuccesState) {
            nameController.text = state.userModel.userName;
            bioController.text = state.userModel.bio ?? '';
            profileImageUrl = state.userModel.profilePic;
            coverImageUrl = state.userModel.backGroundImage;
          }
        },
        builder: (context, userDetailsState) {
          return BlocConsumer<EditUserProfileBloc, EditUserProfileState>(
            listener: (context, state) {
              if (state is EditUserProfileSuccesState) {
                customSnackbar(
                    context, 'Profile details updated', kGreen, Icons.done);
                context
                    .read<SigninUserDetailsBloc>()
                    .add(OnSigninUserDataFetchEvent());
                Navigator.pop(context);
              }
            },
            builder: (context, editProfileState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ValueListenableBuilder<String>(
                        valueListenable: coverImageNotifier,
                        builder: (context, coverImagePath, child) {
                          return Container(
                            width: media.width,
                            height: media.height * 0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: coverImagePath.isNotEmpty
                                    ? FileImage(File(coverImagePath))
                                    : CachedNetworkImageProvider(widget.cvImage)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: -85,
                                  left: 10,
                                  child: ValueListenableBuilder<String>(
                                    valueListenable: profileImageNotifier,
                                    builder:
                                        (context, profileImagePath, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          pickImage(profileImageNotifier);
                                        },
                                        child: Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: kWhiteColor,
                                            border: Border.all(
                                                width: 5, color: kWhiteColor),
                                            image: DecorationImage(
                                              image: profileImagePath.isNotEmpty
                                                  ? FileImage(
                                                      File(profileImagePath))
                                                  : CachedNetworkImageProvider(
                                                          widget.prImage)
                                                      as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                right: 20,
                                                bottom: 10,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.7),
                                                  child: const Icon(Icons.edit,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      pickImage(coverImageNotifier);
                                    },
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.7),
                                      child: const Icon(Icons.edit,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyTextfield(
                              hintText: 'Edit name',
                              controller: nameController,
                            ),
                            SizedBox(height: 20,),
                            MyTextfield(
                              hintText: 'Bio',
                              controller: bioController,
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<EditUserProfileBloc,
                                EditUserProfileState>(
                              builder: (context, state) {
                                if (state is EditUserProfileLoadingState ||
                                    state
                                        is SigninUserDetailsDataFetchLoadingState) {
                                  return loadingButton(
                                      onPressed: () {}, color: kGreen);
                                }
                                return MyButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (userDetailsState
                                          is SigninUserDetailsDataFetchSuccesState) {
                                        context.read<EditUserProfileBloc>().add(
                                              OnEditProfileButtonClickedEvent(
                                                  name: nameController.text,
                                                  bio: bioController.text,
                                                  image: profileImageNotifier
                                                      .value,
                                                  imageUrl: userDetailsState
                                                      .userModel.profilePic,
                                                  bgImage:
                                                      coverImageNotifier.value,
                                                  bgImageUrl: userDetailsState
                                                      .userModel
                                                      .backGroundImage),
                                            );
                                      }
                                    }
                                  },
                                  text: 'Save',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
