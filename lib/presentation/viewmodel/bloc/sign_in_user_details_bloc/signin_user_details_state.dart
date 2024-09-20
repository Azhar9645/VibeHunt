part of 'signin_user_details_bloc.dart';

@immutable
sealed class SigninUserDetailsState {
  get userModel => null;
}

final class SigninUserDetailsInitial extends SigninUserDetailsState {}

final class SigninUserDetailsDataFetchSuccesState extends SigninUserDetailsState {
  final SignInUserModel userModel;

  SigninUserDetailsDataFetchSuccesState({required this.userModel});
}

final class SigninUserDetailsDataFetchErrorState
    extends SigninUserDetailsState {}

final class SigninUserDetailsDataFetchLoadingState
    extends SigninUserDetailsState {}




