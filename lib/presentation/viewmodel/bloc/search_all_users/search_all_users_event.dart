part of 'search_all_users_bloc.dart';

@immutable
sealed class SearchAllUsersEvent {}

final class OnSearchAllUsersEvent extends SearchAllUsersEvent {
  final String query;

  OnSearchAllUsersEvent({required this.query});
}

class OnFetchAllUsersEvent extends SearchAllUsersEvent {}
