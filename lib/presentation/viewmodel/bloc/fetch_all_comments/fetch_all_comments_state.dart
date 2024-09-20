part of 'fetch_all_comments_bloc.dart';

@immutable
sealed class FetchAllCommentsState {}

final class FetchAllCommentsInitial extends FetchAllCommentsState {}

final class FetchAllCommentsLoadingState extends FetchAllCommentsState {}

final class FetchAllCommentsSuccessState extends FetchAllCommentsState {
    final List<Comment> comments;
  FetchAllCommentsSuccessState({required this.comments});
}

final class FetchAllCommentsErrorState extends FetchAllCommentsState {}
