part of 'save_post_bloc.dart';

@immutable
sealed class SavePostState {}

final class SavePostInitial extends SavePostState {}

final class SavePostLoadingState extends SavePostState {}

final class SavePostSuccessState extends SavePostState {
  final SavePostModel post;
  SavePostSuccessState({required this.post});
}

final class SavePostServerError extends SavePostState {}

final class SavePostErrorState extends SavePostState {}

final class UnSavePostLoadingState extends SavePostState {}

final class UnSavePostSuccessState extends SavePostState {}

final class UnSavePostServerError extends SavePostState {}

final class UnSavePostErrorState extends SavePostState {}
