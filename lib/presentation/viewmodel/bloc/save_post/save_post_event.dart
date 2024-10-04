part of 'save_post_bloc.dart';

@immutable
sealed class SavePostEvent {}

class SaveButtonClickedEvent extends SavePostEvent{
  final String postId;
  SaveButtonClickedEvent({required this.postId});
}

class UnSaveButtonClickedEvent extends SavePostEvent{
  final String postId;
  UnSaveButtonClickedEvent({required this.postId});
}