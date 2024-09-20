part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordErrorState extends ForgetPasswordState {
  final String error;
  ForgetPasswordErrorState({required this.error});
}

final class ForgetPasswordSuccessState extends ForgetPasswordState {}

//opt verification
final class OtpverifiedLoadingState extends ForgetPasswordState {}

final class OtpverifiedSuccessState extends ForgetPasswordState {}

final class OtpverifiedErrorState extends ForgetPasswordState {
  final String error;

  OtpverifiedErrorState({required this.error});
}


// reset password
final class ResetPasswordLoadingState extends ForgetPasswordState {}

final class ResetPasswordSuccessState extends ForgetPasswordState {}

final class ResetPasswordErrorState extends ForgetPasswordState {
  final String error;

  ResetPasswordErrorState({required this.error});
}
