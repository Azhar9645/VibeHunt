part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

class OnForgetButtonClicked extends ForgetPasswordEvent {
  final String email;

  OnForgetButtonClicked({required this.email});
}

class OnVerifyButtonClickedEvent extends ForgetPasswordEvent {
  final String otp;
  final String email;

  OnVerifyButtonClickedEvent({required this.otp, required this.email});
}

class OnResetPasswordButtonClickedEvent extends ForgetPasswordEvent {
  final String email;
  final String password;

  OnResetPasswordButtonClickedEvent(
      {required this.email, required this.password});
}
