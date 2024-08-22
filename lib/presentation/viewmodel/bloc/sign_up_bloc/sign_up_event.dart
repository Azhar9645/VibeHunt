part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignupButtonClicked extends SignUpEvent {
  final String userName;
  final String password;
  final String phoneNumber;
  final String email;

  SignupButtonClicked(
      {required this.userName,
      required this.password,
      required this.phoneNumber,
      required this.email});
}