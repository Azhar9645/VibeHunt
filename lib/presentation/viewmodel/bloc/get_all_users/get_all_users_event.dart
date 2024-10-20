part of 'get_all_users_bloc.dart';

@immutable
sealed class GetAllUsersEvent {}

class FetchGetAllUsersEvent extends GetAllUsersEvent {}
