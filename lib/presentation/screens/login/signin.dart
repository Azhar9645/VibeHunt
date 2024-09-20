import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/presentation/screens/base/base_screen.dart';
import 'package:vibehunt/presentation/screens/login/forget%20password/forget_password.dart';
import 'package:vibehunt/presentation/screens/login/signup.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccesState) {
            customSnackbar(context, 'welcome back', kGreen, Icons.done);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return BaseScreen();
              }),
              (Route<dynamic> route) => false,
            );
          } else if (state is SignInErrorState) {
            customSnackbar(context, state.error, kRed, Icons.error);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(18.w), // Responsive padding
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    SizedBox(height: 70.h), // Responsive spacing
                    Image.asset(
                      'assets/logo/vibehunt logo.png',
                      width: 400.w, // Responsive image width
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Getting Started.!',
                        style: TextStyle(
                          fontSize: 22.sp, // Responsive font size
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
                    MyTextfield(
                      controller: passwordController,
                      hintText: 'Your password',
                      obscureText: true,
                      maxline: 1,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24.sp, // Responsive icon size
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[^\w]'))) {
                          return 'Password must contain at least one non-alphabetic character';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ));
                            },
                            child: const Text('Forgot password?',
                                style: TextStyle(color: kGreen))),
                      ],
                    ),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        if (state is SignInLoadingState) {
                          return loadingButton(
                            onPressed: () {}, // Disable during loading
                            color: kGreen,
                          );
                        }
                        return MyButton(
                          text: 'Sign In',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(
                                  SignInButtonClickEvent(
                                      email: emailController.text,
                                      password: passwordController.text));
                            } else {
                              customSnackbar(context, 'Fill All Fields', kRed,
                                  Icons.fast_forward);
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Or Continue with',
                      style: jStyleW.copyWith(
                          fontSize: 14.sp), // Responsive font size
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          if (state is GoogleAuthLoadingstate) {
                            return const CircularProgressIndicator();
                          }
                          return GestureDetector(
                            onTap: () async {
                              context
                                  .read<SignInBloc>()
                                  .add(OnGoogleSignInButtonClickedEvent());
                            },
                            child: Container(
                              width: 55.w, // Responsive size
                              height: 55.w, // Responsive size
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/google.png',
                                  width: 55.w,
                                  height: 55.w,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have any account?',
                          style: TextStyle(
                            fontSize: 16.sp, // Responsive font size
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16.sp, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: kGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
