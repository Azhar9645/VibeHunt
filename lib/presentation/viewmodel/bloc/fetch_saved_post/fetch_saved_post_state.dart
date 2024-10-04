part of 'fetch_saved_post_bloc.dart';

@immutable
sealed class FetchSavedPostState {}

final class FetchSavedPostInitial extends FetchSavedPostState {}

final class FetchSavedPostLoadingState extends FetchSavedPostState {}

final class FetchSavedPostSuccessState extends FetchSavedPostState {
  final List<SavedPostModel> posts;
  FetchSavedPostSuccessState({required this.posts});
}

final class FetchSavedPostServerError extends FetchSavedPostState {}

final class FetchSavedPostErrorState extends FetchSavedPostState {}
