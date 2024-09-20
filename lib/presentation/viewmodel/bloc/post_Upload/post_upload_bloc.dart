import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'post_upload_event.dart';
part 'post_upload_state.dart';

class PostUploadBloc extends Bloc<PostUploadEvent, PostUploadState> {
  PostUploadBloc() : super(PostUploadInitial()) {
    on<OnUploadButtonClickedEvent>((event, emit) async {
      emit(PostUploadLoadingState());

      // Ensure the tags are passed correctly to the repository function
      final response = await PostRepo.addPost(
          event.description, event.imagePath, event.tags);

      if (response != null && response.statusCode == 200) {
        emit(PostUploadSuccesState());

        if (kDebugMode) {
          print(response.body);
        }
      } else if (response != null) {
        emit(PostUploadErrorState(error: 'Something went wrong'));
      } else {
        emit(PostUploadErrorState(error: 'Unknown error'));
      }
    });
  }
}
