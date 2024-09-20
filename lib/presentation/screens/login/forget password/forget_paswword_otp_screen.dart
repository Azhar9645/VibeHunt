import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vibehunt/presentation/screens/login/forget%20password/new_password_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/forget_password/forget_password_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordOtpScreen extends StatelessWidget {
  final String email;

  ForgetPasswordOtpScreen({super.key, required this.email});

  bool validateOtp(String otp) {
    return otp.length == 4 && RegExp(r'^[0-9]{4}$').hasMatch(otp);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController pinController = TextEditingController();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 22, color: Colors.white), // Text color set to white
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Colors.white), // Outline border color set to white
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter OTP',
          style: j24,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/Otp.json',
                width: 400.w,
                height: 400.h,
                fit: BoxFit.cover,
              ),
              Text(
                'We have sent you an OTP to your registered email.',
                style: j20,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
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
                    border: Border.all(
                        color: Colors.white), // Focused border color white
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.white), // Submitted border color white
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                listener: (context, state) {
                  if (state is OtpverifiedSuccessState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewPasswordOtpScreen(email: email),
                      ),
                    );
                  } else if (state is OtpverifiedErrorState) {
                    customSnackbar(context, state.error, kRed, Icons.error);
                  }
                },
                builder: (context, state) {
                  if (state is OtpverifiedLoadingState) {
                    return loadingButton(onPressed: () {}, color: kGreen);
                  }
                  return MyButton(
                    onPressed: () async {
                      String otp = pinController.text;
                      if (validateOtp(otp)) {
                        debugPrint('Entered OTP: $otp');
                        context.read<ForgetPasswordBloc>().add(
                            OnVerifyButtonClickedEvent(email: email, otp: otp));
                        pinController.clear();
                      } else {
                        customSnackbar(
                            context,
                            'Please enter a valid 4-digit OTP',
                            kRed,
                            Icons.error);
                      }
                    },
                    text: 'Verify',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
