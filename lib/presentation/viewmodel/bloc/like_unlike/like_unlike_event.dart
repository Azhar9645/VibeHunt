part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeEvent {}

class LikeButtonClickEvent extends LikeUnlikeEvent {
  final String postId;

  LikeButtonClickEvent({required this.postId});
}

class UnlikeButtonClickEvent extends LikeUnlikeEvent {
  final String postId;

  UnlikeButtonClickEvent({required this.postId});
}
