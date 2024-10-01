import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/models/following_model.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'fetchfollowing_event.dart';
part 'fetchfollowing_state.dart';

class FetchfollowingBloc
    extends Bloc<FetchfollowingEvent, FetchfollowingState> {
  FetchfollowingBloc() : super(FetchfollowingInitial()) {
    on<FetchfollowingEvent>((event, emit) async {
      emit(FetchfollowingLoadingState());
      final Response result = await UserRepo.fetchFollowing();
      debugPrint('followers fetch status code-${result.statusCode}');
      if (result.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(result.body);
        final FollowingsModel followingsModel =
            FollowingsModel.fromJson(responseBody);
        return emit(FetchfollowingSuccessState(following: followingsModel));
      } else {
        //  print("error");
        return emit(FetchfollowingErrorState());
      }
    });
  }
}
