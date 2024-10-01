import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/models/profile/post_model.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';
import 'package:vibehunt/utils/funtions.dart';

part 'fetch_users_post_event.dart';
part 'fetch_users_post_state.dart';

class FetchUsersPostBloc
    extends Bloc<FetchUsersPostEvent, FetchUsersPostState> {
  FetchUsersPostBloc() : super(FetchUsersPostInitial()) {
    on<FetchUsersPostEvent>((event, emit) {});
    on<UsersInitialPostFetchEvent>(usersInitialPostFetchEvent);

  }

  FutureOr<void> usersInitialPostFetchEvent(
      UsersInitialPostFetchEvent event, Emitter<FetchUsersPostState> emit) async {
    emit(FetchUsersPostLoadingState());
    debugPrint('event user id is -${event.userId}');
    final Response result =
        await UserRepo.fetchUserPostsOther(userId: event.userId);
    final responseBody = jsonDecode(result.body);
    final List<Post> posts = parsePosts(result.body);
    debugPrint('user posts:-$responseBody');

    if (result.statusCode == 200) {
      // log(responseBody.toString());
      emit(FetchUsersPostSuccessState(posts: posts));
    } else if (responseBody['status'] == 404) {
      emit(FetchUsersPostErrorState());
    }
  }
}
