import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vibehunt/presentation/screens/login/forget%20password/forget_paswword_otp_screen.dart';
import 'package:vibehunt/presentation/screens/login/forget%20password/new_password_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/forget_password/forget_password_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';
import 'package:vibehunt/utils/constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Reset',
          style: j24,
        ),
      ),
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ForgetPasswordOtpScreen(
                  email: emailController.text,
                ),
                fullscreenDialog: true,
              ),
            );
          } else if (state is ForgetPasswordErrorState) {
            customSnackbar(context, state.error, kRed, Icons.error);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(18.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/lottie/aoHWrocO4g.json', // Path to your Lottie file
                      width: 400.w, // Adjust width and height as needed
                      height: 400.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 50.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please Enter Your Email Address To Recieve a OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp, // Responsive font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    MyTextfield(
                      controller: emailController,
                      hintText: 'abc@email.com',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 24.sp, // Responsive icon size
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(value)) {
                          return 'Enter a valid Gmail address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                      builder: (context, state) {
                        if (state is ForgetPasswordLoadingState) {
                          return loadingButton(onPressed: () {}, color: kGreen);
                        }

                        return MyButton(
                          text: 'Get OTP',
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              context.read<ForgetPasswordBloc>().add(
                                  OnForgetButtonClicked(
                                      email: emailController.text));
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
