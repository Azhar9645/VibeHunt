import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';
import 'package:vibehunt/data/models/following_post_model.dart';
import 'package:http/http.dart' as http;
import 'package:vibehunt/data/repositories/post_repo.dart';
import 'package:vibehunt/utils/api_url.dart';
import 'package:vibehunt/utils/funtions.dart'; // Assuming you use http package

part 'fetch_all_following_post_event.dart';
part 'fetch_all_following_post_state.dart';

class FetchAllFollowingPostBloc
    extends Bloc<FetchAllFollowingPostEvent, FetchAllFollowingPostState> {
  int page = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true; // Track if there's more data to load
  List<FollowingPostModel> allPosts = [];

  FetchAllFollowingPostBloc() : super(FetchAllFollowingPostInitial()) {
    on<AllFollowingsPostsInitialFetchEvent>(allFollowersPostsInitialFetchEvent);
    on<LoadMoreEvent>(loadMoreEvent);
  }

  // Fetch initial set of posts
  Future<void> allFollowersPostsInitialFetchEvent(
      AllFollowingsPostsInitialFetchEvent event,
      Emitter<FetchAllFollowingPostState> emit) async {
    emit(FetchAllFollowingPostLoading());
    page = 1;
    hasMoreData = true; // Reset on initial fetch

    try {
      final http.Response result =
          await PostRepo.getAllFollowingPost(page: page);

      if (result.statusCode == 200) {
        List<FollowingPostModel> posts = (jsonDecode(result.body) as List)
            .map((json) => FollowingPostModel.fromJson(json))
            .toList();

        allPosts = posts; // Reset list to avoid duplicates
        emit(FetchAllFollowingPostSuccess(posts: allPosts));

        if (posts.isEmpty) {
          hasMoreData = false; // No more data to load
        }
      } else {
        emit(FetchAllFollowingPostErrorState(error: 'Failed to fetch posts.'));
      }
    } catch (error) {
      emit(FetchAllFollowingPostErrorState(error: 'An error occurred.'));
    }
  }

  // Load more posts
  Future<void> loadMoreEvent(
      LoadMoreEvent event, Emitter<FetchAllFollowingPostState> emit) async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    page += 1; // Increment the page count

    try {
      final http.Response result =
          await PostRepo.getAllFollowingPost(page: page);

      if (result.statusCode == 200) {
        List<FollowingPostModel> newPosts = (jsonDecode(result.body) as List)
            .map((json) => FollowingPostModel.fromJson(json))
            .toList();

        if (newPosts.isNotEmpty) {
          allPosts.addAll(newPosts); // Append new posts to the list
          emit(FetchMorePostSuccessState(posts: allPosts));
        } else {
          hasMoreData = false; // No more data available
        }
      } else {
        emit(FetchMorePostErrorState());
      }
    } catch (error) {
      emit(FetchMorePostErrorState());
    }

    isLoadingMore = false;
  }
}
