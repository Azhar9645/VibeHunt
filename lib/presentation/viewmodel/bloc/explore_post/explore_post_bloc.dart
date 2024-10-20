import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/models/explore_post_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'explore_post_event.dart';
part 'explore_post_state.dart';

class ExplorePostBloc extends Bloc<ExplorePostEvent, ExplorePostState> {
  ExplorePostBloc() : super(ExplorePostInitial()) {
    on<ExplorePostEvent>((event, emit) async {
      emit(ExplorePostLoadingState()); // Emit loading state
      // debugPrint('Loading state emitted'); // Log loading state

      try {
        final Response response = await PostRepo.fetchExplorePosts();
        // debugPrint(
        //     'API response received with status code: ${response.statusCode}');

        if (response.statusCode == 200) {
          final List<dynamic> responseBody = jsonDecode(response.body);
          // debugPrint('Decoded response body: $responseBody');

          // Check if response has data
          if (responseBody.isNotEmpty) {
            List<ExplorePostModel> posts = responseBody
                .map((json) => ExplorePostModel.fromJson(json))
                .toList();
            // debugPrint('Posts parsed: $posts');

            if (posts.isNotEmpty) {
              emit(ExplorePostSuccessState(posts: posts));
              // debugPrint('Success state emitted with posts');
            } else {
              emit(ExplorePostSuccessState(posts: []));
              // debugPrint('Success state emitted with empty posts');
            }
          } else {
            emit(ExplorePostSuccessState(posts: []));
            // debugPrint('Empty response, emitting success with no posts');
          }
        } else {
          emit(ExplorePostErrorState());
          // debugPrint('Error: Status code is not 500');
        }
      } catch (e) {
        debugPrint('Exception caught: $e');
        emit(ExplorePostErrorState());
      }
    });
  }
}
