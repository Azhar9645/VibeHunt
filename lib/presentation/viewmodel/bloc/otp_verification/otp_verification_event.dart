part of 'otp_verification_bloc.dart';

@immutable
sealed class OtpVerificationEvent {}

class OnOtpVerifyButtonClicked extends OtpVerificationEvent {
  final String otp;
  final String email;

  OnOtpVerifyButtonClicked({required this.otp, required this.email});
}
