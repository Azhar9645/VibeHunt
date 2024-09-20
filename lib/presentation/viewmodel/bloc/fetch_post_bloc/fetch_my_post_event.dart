part of 'fetch_my_post_bloc.dart';

@immutable
sealed class FetchMyPostEvent {}

final class FetchAllMyPostsEvent extends FetchMyPostEvent {}

final class PostDeleteButtonPressedEvent extends FetchMyPostEvent {
  final String postId;

  PostDeleteButtonPressedEvent({required this.postId});
}

final class EditPostButtonClicked extends FetchMyPostEvent {
  final String description;
  final String postId;
  final List<String> tags;


  EditPostButtonClicked({
    required this.tags,
    required this.description,
    required this.postId,
  });

  
}
