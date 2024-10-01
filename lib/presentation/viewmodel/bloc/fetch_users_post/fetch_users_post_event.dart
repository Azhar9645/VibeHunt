part of 'fetch_users_post_bloc.dart';

@immutable
sealed class FetchUsersPostEvent {}

class UsersInitialPostFetchEvent extends FetchUsersPostEvent {
  final String userId;

  UsersInitialPostFetchEvent({required this.userId});
}