part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInSuccesState extends SignInState {}

final class SignInErrorState extends SignInState {
  final String error;

  SignInErrorState({required this.error});
}

final class SignInLoadingState extends SignInState {}

final class GoogleAuthLoadingstate extends SignInState {}
