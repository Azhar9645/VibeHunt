part of 'fetch_all_users_bloc.dart';

@immutable
sealed class FetchAllUsersState {}

final class FetchAllUsersInitial extends FetchAllUsersState {}

final class FetchAllUsersLoadingState extends FetchAllUsersState {}

final class FetchAllUsersSuccessState extends FetchAllUsersState {
    final List<AllUser> users;
   final int total;
  final int page;

  FetchAllUsersSuccessState({required this.users, required this.total, required this.page});
}

final class FetchAllUsersErrorState extends FetchAllUsersState {
  final String error;
  FetchAllUsersErrorState({required this.error});
}

