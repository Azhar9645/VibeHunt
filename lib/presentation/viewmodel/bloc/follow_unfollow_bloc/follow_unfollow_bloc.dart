import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  FollowUnfollowBloc() : super(FollowUnfollowInitial()) {
    on<OnFollowButtonClickedEvent>(_followButtonClickEvent);
    on<OnUnFollowButtonClickedEvent>(_unfollowButtonClickEvent);
  }

  // Event handler for follow button click
  Future<void> _followButtonClickEvent(OnFollowButtonClickedEvent event,
      Emitter<FollowUnfollowState> emit) async {
    emit(FollowUserLoadingState());
    try {
      final Response result =
          await UserRepo.followUser(followerId: event.followerId);
      debugPrint('Follow status code: ${result.statusCode}');

      if (result.statusCode == 200) {
        emit(FollowUserSuccessState());
      } else {
        emit(FollowUserErrorState());
      }
    } catch (e) {
      debugPrint('Follow request failed with error: $e');
      emit(FollowUserErrorState());
    }
  }

  // Event handler for unfollow button click
  Future<void> _unfollowButtonClickEvent(OnUnFollowButtonClickedEvent event,
      Emitter<FollowUnfollowState> emit) async {
    emit(UnFollowUserLoadingState());
    try {
      final Response result =
          await UserRepo.unfollowUser(followerId: event.followerId);
      debugPrint('Unfollow status code: ${result.statusCode}');

      if (result.statusCode == 200) {
        emit(UnFollowUserSuccessState());
      } else {
        emit(FollowUserErrorState());
      }
    } catch (e) {
      debugPrint('Unfollow request failed with error: $e');
      emit(FollowUserErrorState());
    }
  }
}
