part of 'fetch_all_comments_bloc.dart';

@immutable
sealed class FetchAllCommentsEvent {}

class CommentsFetchEvent extends FetchAllCommentsEvent {
  final String postId;

  CommentsFetchEvent({required this.postId});
}