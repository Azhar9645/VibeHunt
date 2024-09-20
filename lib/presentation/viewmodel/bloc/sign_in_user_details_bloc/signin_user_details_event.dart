part of 'signin_user_details_bloc.dart';

@immutable
sealed class SigninUserDetailsEvent {}
final class OnSigninUserDataFetchEvent  extends SigninUserDetailsEvent{}

