import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vibehunt/presentation/screens/login/signin.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/forget_password/forget_password_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';

class NewPasswordOtpScreen extends StatelessWidget {
  final String email;

  NewPasswordOtpScreen({super.key, required this.email});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: j24,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/aoHWrocO4g.json', // Path to your Lottie file
                  width: 400.w, // Adjust width and height as needed
                  height: 400.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 50.h), // Adjust height as needed
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Enter new password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
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
                  maxline: 1,
                ),
                SizedBox(height: 20.h), // Adjust height as needed
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  maxline: 1,
                ),
                SizedBox(height: 30.h), // Adjust height as needed
                BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccessState) {
                      customSnackbar(context, 'Password reset successful',
                          kGreen, Icons.done);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                        (Route<dynamic> route) => false,
                      );
                    } else if (state is ResetPasswordErrorState) {
                      customSnackbar(context, state.error, kRed, Icons.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordLoadingState) {
                      return loadingButton(
                          onPressed: () {}, color: kDefaultIconLightColor);
                    }
                    return MyButton(
                      text: 'Submit',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ForgetPasswordBloc>().add(
                                OnResetPasswordButtonClickedEvent(
                                    email: email,
                                    password: confirmPasswordController.text),
                              );
                        } else {
                          customSnackbar(context, 'Please fix the errors', kRed,
                              Icons.error);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
