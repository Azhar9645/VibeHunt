import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/user_model.dart';
import 'package:vibehunt/presentation/screens/login/signin.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final UserModel user;
  final String email;

  const OTPScreen({super.key, required this.email, required this.user});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController pinController = TextEditingController();
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
    pinController.dispose();
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

  bool validateOtp(String otp) {
    return otp.length == 4 && RegExp(r'^[0-9]{4}$').hasMatch(otp);
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();
    var media = MediaQuery.of(context).size;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Colors.white), // Text color set to white
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white), // Outline border color set to white
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        listener: (context, state) {
          if (state is OtpVerificationSuccesState) {
            customSnackbar(context, 'OTP verification successful', Colors.green, Icons.done);
            pinController.clear();
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
                  Pinput(
                    length: 4,
                    controller: pinController,
                    defaultPinTheme: defaultPinTheme,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 24,
                          height: 2,
                          color: Colors.white, // Cursor color white
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white), // Focused border color white
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white), // Submitted border color white
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                    builder: (context, state) {
                      if (state is OtpVerificationLoadingState) {
                        return loadingButton(onPressed: () {}, color: kGreen);
                      }
                      return MyButton(
                        text: 'Verify',
                        onPressed: () async {
                          String otp = pinController.text;
                          if (validateOtp(otp)) {
                            debugPrint('Entered OTP: $otp');
                            context.read<OtpVerificationBloc>().add(
                                OnOtpVerifyButtonClicked(
                                    otp: otp, email: widget.email));
                            pinController.clear();
                          } else {
                            customSnackbar(
                                context,
                                'Please enter a valid 4-digit OTP',
                                Colors.red,
                                Icons.error);
                          }
                        },
                      );
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
