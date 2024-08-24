part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpSuccesState extends OtpState {}

final class OtpLoadingState extends OtpState {}

final class OtpErrrorState extends OtpState {
  final String error;

  OtpErrrorState({required this.error});
}
