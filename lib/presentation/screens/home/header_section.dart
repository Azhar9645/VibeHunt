import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_user_details_bloc/signin_user_details_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

Widget buildHeader(BuildContext context) {
  return BlocBuilder<SigninUserDetailsBloc, SigninUserDetailsState>(
    builder: (context, state) {
      String userName = 'User'; // Default user name
      if (state is SigninUserDetailsDataFetchSuccesState) {
        userName =
            ((state.userModel.name ?? state.userModel.userName)).toUpperCase();
      }

      return Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hi, $userName', style: j24),
              // IconButton(
              //   icon: const Icon(Icons.notifications_active_outlined,
              //       color: kWhiteColor, size: 35),
              //   onPressed: () {
              //     // Action for notification icon
              //   },
              // ),
            ],
          ),
        ],
      );
    },
  );
}
