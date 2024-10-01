part of 'user_connection_count_bloc.dart';

@immutable
sealed class UserConnectionCountEvent {}

class UserConnectionsInitilFetchEvent extends UserConnectionCountEvent {
  final String userId;

  UserConnectionsInitilFetchEvent({required this.userId});
}