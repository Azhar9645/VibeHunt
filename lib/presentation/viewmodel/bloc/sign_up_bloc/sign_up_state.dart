part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccesState extends SignUpState {}

final class SignUpLoadingSate extends SignUpState {}

final class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
}