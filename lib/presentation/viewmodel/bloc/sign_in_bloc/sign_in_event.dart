part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SignInButtonClickEvent extends SignInEvent {
  final String email;
  final String password;

  SignInButtonClickEvent({required this.email, required this.password});
}

class OnGoogleSignInButtonClickedEvent extends SignInEvent {}

