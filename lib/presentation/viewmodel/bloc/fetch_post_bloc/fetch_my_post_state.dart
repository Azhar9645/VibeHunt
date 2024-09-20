part of 'fetch_my_post_bloc.dart';

@immutable
sealed class FetchMyPostState {}

final class FetchMyPostInitial extends FetchMyPostState {}

final class FetchMyPostSuccessState extends FetchMyPostState {
 final List<MyPostModel> posts;

  FetchMyPostSuccessState({required this.posts});
}

final class FetchMyPostLoadingState extends FetchMyPostState {}

final class FetchMyPostErrorState extends FetchMyPostState {
  final String error;

  FetchMyPostErrorState({required this.error});
}

final class EditUserPostLoadingState extends FetchMyPostState {}

final class EditUserPostSuccessState extends FetchMyPostState {}

final class EditUserPostErrorState extends FetchMyPostState {
  final String error;

  EditUserPostErrorState({required this.error});
}

final class OnDeleteButtonClickedLoadingState extends FetchMyPostState {}

final class OnDeleteButtonClickedSuccesState extends FetchMyPostState {}

final class OnDeleteButtonClickedErrrorState extends FetchMyPostState {
  final String error;

  OnDeleteButtonClickedErrrorState({required this.error});
}



