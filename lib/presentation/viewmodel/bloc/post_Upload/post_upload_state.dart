part of 'post_upload_bloc.dart';

@immutable
sealed class PostUploadState {}

final class PostUploadInitial extends PostUploadState {}

final class PostUploadSuccesState extends PostUploadState {}

final class PostUploadErrorState extends PostUploadState {
  final String error;
  PostUploadErrorState({required this.error});
}

final class PostUploadLoadingState extends PostUploadState {}



