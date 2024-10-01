part of 'create_comment_bloc.dart';

@immutable
sealed class CreateCommentState {}

final class CreateCommentInitial extends CreateCommentState {}

final class CreateCommentLoadingState extends CreateCommentState {}

final class CreateCommentSuccessState extends CreateCommentState {
  final String commentId;

  CreateCommentSuccessState({required this.commentId});
}

final class CreateCommentNotFoundState extends CreateCommentState {}

final class CreateCommentErrorState extends CreateCommentState {}
