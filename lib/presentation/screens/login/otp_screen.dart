import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/user_model.dart';
import 'package:vibehunt/presentation/screens/login/signin.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';

class OTPScreen extends StatefulWidget {
  final UserModel user;
  final String email;

  const OTPScreen({super.key, required this.email, required this.user});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> otpController =
      List.generate(4, (index) => TextEditingController());
  late Timer timer;
  Timer? debounceTimer;
  int start = 60;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    debounceTimer?.cancel();
    for (var otp in otpController) {
      otp.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    isVisible = false;
    start = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        setState(() {
          isVisible = true;
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void reSendOtp(SignUpBloc signUpBloc) {
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
    debounceTimer = Timer(const Duration(seconds: 1), () {
      signUpBloc.add(SignupButtonClicked(
          userName: widget.user.userName,
          password: widget.user.password,
          phoneNumber: widget.user.phoneNumber,
          email: widget.user.emailId));
      startTimer();
    });
  }

  bool validateOtp() {
    for (var controller in otpController) {
      if (controller.text.isEmpty ||
          controller.text.length != 1 ||
          !RegExp(r'^[0-9]$').hasMatch(controller.text)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        listener: (context, state) {
          if (state is OtpVerificationSuccesState) {
            customSnackbar(
                context, ' otp verfication succen', Colors.green, Icons.done);
            for (var controller in otpController) {
              controller.clear();
            }
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignInScreen()),
              (Route<dynamic> route) => false,
            );
          } else if (state is OtpVerificationErrrorState) {
            customSnackbar(context, 'Invalid OTP', Colors.amber, Icons.error);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus(); // Dismiss the keyboard
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter the 4-digit OTP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 60,
                        child: TextField(
                          controller: otpController[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          reSendOtp(signUpBloc);
                        },
                        child: Text(
                          'Resend OTP',
                          style: j20G,
                        )),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                    builder: (context, state) {
                      if (state is OtpVerificationLoadingState) {
                        return loadingButton(
                            media: media, onPressed: () {}, color: kGreen);
                      }
                      return MyButton(
                          text: 'Verify',
                          onPressed: () async {
                            if (validateOtp()) {
                              String otp = otpController
                                  .map((controller) => controller.text)
                                  .join();
                              debugPrint('Entered OTP: $otp');
                              context.read<OtpVerificationBloc>().add(
                                  OnOtpVerifyButtonClicked(
                                      otp: otp, email: widget.email));

                              for (var controller in otpController) {
                                controller.clear();
                              }
                            } else {
                              customSnackbar(
                                  context,
                                  'Please enter a valid 4-digit OTP',
                                  Colors.red,
                                  Icons.error);
                            }
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
