part of 'create_comment_bloc.dart';

@immutable
sealed class CreateCommentEvent {}

class CommentPostButtonClickEvent extends CreateCommentEvent {
  final String userName;
  final String postId;
  final String content;

  CommentPostButtonClickEvent(
      {required this.userName, required this.postId, required this.content});
}