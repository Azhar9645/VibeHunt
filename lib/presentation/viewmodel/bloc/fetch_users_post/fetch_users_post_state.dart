part of 'fetch_users_post_bloc.dart';

@immutable
sealed class FetchUsersPostState {}

final class FetchUsersPostInitial extends FetchUsersPostState {}

final class FetchUsersPostLoadingState extends FetchUsersPostState {}

final class FetchUsersPostSuccessState extends FetchUsersPostState {
  final List<Post>posts;

  FetchUsersPostSuccessState({required this.posts});
}

final class FetchUsersPostErrorState extends FetchUsersPostState {}

