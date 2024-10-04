import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/models/saved_post_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'fetch_saved_post_event.dart';
part 'fetch_saved_post_state.dart';

class FetchSavedPostBloc
    extends Bloc<FetchSavedPostEvent, FetchSavedPostState> {
  FetchSavedPostBloc() : super(FetchSavedPostInitial()) {
    on<FetchSavedPostEvent>((event, emit) {});
    on<SavedPostsInitialFetchEvent>(savedPostsInitialFetchEvent);
  }

  FutureOr<void> savedPostsInitialFetchEvent(SavedPostsInitialFetchEvent event,
      Emitter<FetchSavedPostState> emit) async {
    emit(FetchSavedPostLoadingState());
    final Response result = await PostRepo.fetchSavedPosts();
    final responseBody = jsonDecode(result.body);
    final List data = responseBody;
    debugPrint('saved post fetch statuscode-${result.statusCode}');

    if (result.statusCode == 200) {
      final List<SavedPostModel> posts =
          data.map((json) => SavedPostModel.fromJson(json)).toList();
      emit(FetchSavedPostSuccessState(posts: posts));
    } else if (result.statusCode == 500) {
      emit(FetchSavedPostServerError());
    } else {
      emit(FetchSavedPostErrorState());
    }
  }
}
