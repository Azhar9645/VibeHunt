import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/explore_post_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'explore_post_event.dart';
part 'explore_post_state.dart';

class ExplorePostBloc extends Bloc<ExplorePostEvent, ExplorePostState> {
  ExplorePostBloc() : super(ExplorePostInitial()) {
    on<ExplorePostEvent>((event, emit) async {
      emit(ExplorePostLoadingState());

      final Response response = await PostRepo.fetchExplorePosts();
      debugPrint('status code  fetch explore : ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);

        List<ExplorePostModel> posts = responseBody
            .map((json) => ExplorePostModel.fromJson(json))
            .toList();
            print('Response body: ${response.body}');


        return emit(ExplorePostSuccessState(posts: posts));
      } else {
        return emit(ExplorePostErrorState());
      }
    });
  }
}
