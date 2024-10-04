import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/save_post_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'save_post_event.dart';
part 'save_post_state.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostInitial()) {
    on<SavePostEvent>((event, emit) {});
    on<SaveButtonClickedEvent>(saveButtonClickedEvent);
    on<UnSaveButtonClickedEvent>(unSaveButtonClickedEvent);
  }

  FutureOr<void> saveButtonClickedEvent(
      SaveButtonClickedEvent event, Emitter<SavePostState> emit) async {
   
    emit(SavePostLoadingState());
    final Response result = await PostRepo.savePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);

    debugPrint('save post statuscode-${result.statusCode}');

    if (result.statusCode == 200) {
      final SavePostModel post = SavePostModel.fromJson(responseBody);
      emit(SavePostSuccessState(post: post));
    } else if (result.statusCode == 500) {
      emit(SavePostServerError());
    } else {
      emit(SavePostErrorState());
    }
  }

  FutureOr<void> unSaveButtonClickedEvent(
      UnSaveButtonClickedEvent event,
      Emitter<SavePostState> emit) async {
    emit(UnSavePostLoadingState());
    final Response result =
        await PostRepo.unSavedPost(postId: event.postId);
    debugPrint('delete saved post statuscode-${result.statusCode}');
    if (result.statusCode == 200) {
      emit(UnSavePostSuccessState());
    } else if (result.statusCode == 500) {
      emit(UnSavePostServerError());
    } else {
      emit(UnSavePostErrorState());
    }
  }
}
