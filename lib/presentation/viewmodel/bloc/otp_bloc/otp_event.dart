part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class OnOtpVerifyButtonClicked extends OtpEvent {
  final String otp;
  final String email;

  OnOtpVerifyButtonClicked({required this.otp, required this.email});
}