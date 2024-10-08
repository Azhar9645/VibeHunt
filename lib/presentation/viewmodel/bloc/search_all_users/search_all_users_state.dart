part of 'search_all_users_bloc.dart';

@immutable
sealed class SearchAllUsersState {}

final class SearchAllUsersInitial extends SearchAllUsersState {}

final class SearchAllUsersLoadingState extends SearchAllUsersState {}

final class SearchAllUsersSuccessState extends SearchAllUsersState {
  final List<UserIdSearchModel> users;
  SearchAllUsersSuccessState({required this.users});
}

final class SearchAllUsersErrorState extends SearchAllUsersState {}

