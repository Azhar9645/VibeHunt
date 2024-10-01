part of 'user_connection_count_bloc.dart';

@immutable
sealed class UserConnectionCountState {}

final class UserConnectionCountInitial extends UserConnectionCountState {}

final class UserConnectionCountLoadingState extends UserConnectionCountState {}

final class UserConnectionCountSuccessState extends UserConnectionCountState {
  final int followersCount;
  final int followingsCount;

  UserConnectionCountSuccessState({required this.followersCount,required this.followingsCount});
}

final class UserConnectionCountErrorState extends UserConnectionCountState {}

