part of 'otp_verification_bloc.dart';

@immutable
sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationSuccesState extends OtpVerificationState {}

final class OtpVerificationLoadingState extends OtpVerificationState {}

final class OtpVerificationErrrorState extends OtpVerificationState {
  final String error;

  OtpVerificationErrrorState({required this.error});
}