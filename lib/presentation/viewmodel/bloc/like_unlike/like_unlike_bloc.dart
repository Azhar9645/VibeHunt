import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc() : super(LikeUnlikeInitial()) {
    on<LikeUnlikeEvent>((event, emit) {});

     on<LikeButtonClickEvent>(likeButtonClickEvent);
    on<UnlikeButtonClickEvent>(unlikeButtonClickEvent);
  }

  Future<void> likeButtonClickEvent(
      LikeButtonClickEvent event, Emitter<LikeUnlikeState> emit) async {
    emit(LikeLoadingState());
    final Response result = await PostRepo.likePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);
    debugPrint(result.statusCode.toString());
    debugPrint(result.body);
    if (result.statusCode == 200) {
      emit(LikeSuccessState());
    } else if (responseBody['status'] == 404) {
      emit(LikeNotFoundState());
    } else if (responseBody['message'] == 'User already liked the post') {
      emit(AlreadyLikedState());
    } else if (responseBody['status'] == 500) {
      emit(LikeErrorState());
    }
  }

  Future<void> unlikeButtonClickEvent(
      UnlikeButtonClickEvent event, Emitter<LikeUnlikeState> emit) async {
    emit(UnlikeLoadingState());
    final Response result = await PostRepo.unlikePost(postId: event.postId);
    final responseBody = jsonDecode(result.body);
    debugPrint(result.statusCode.toString());
    debugPrint(result.body);
    if (result.statusCode == 200) {
      emit(UnlikeSuccessState());
    } else if (responseBody['status'] == 404) {
      emit(UnlikeNotFoundState());
    } else if (responseBody['message'] == 'User has not liked the post') {
      emit(UserNotLikedState());
    } else if (responseBody['status'] == 500) {
      emit(UnlikeErrorState());
}

  }
}
