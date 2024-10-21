part of 'fetch_all_users_bloc.dart';

@immutable
abstract class FetchAllUsersEvent {}

class OnFetchAllUserEvent extends FetchAllUsersEvent {
  final int page;
  final int limit;

  OnFetchAllUserEvent({required this.page, required this.limit});
}


