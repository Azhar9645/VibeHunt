part of 'get_all_users_bloc.dart';

@immutable
sealed class GetAllUsersState {}

final class GetAllUsersInitial extends GetAllUsersState {}

final class GetAllUsersLoadingState extends GetAllUsersState {}

final class GetAllUsersSuccessState extends GetAllUsersState {
  final List<GetAllUsersModel > users;
  GetAllUsersSuccessState({required this.users});
}

final class GetAllUsersErrorState extends GetAllUsersState {}

