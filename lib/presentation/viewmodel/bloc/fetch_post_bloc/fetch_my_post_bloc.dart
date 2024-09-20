import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/my_post/my_post_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';

part 'fetch_my_post_event.dart';
part 'fetch_my_post_state.dart';

class FetchMyPostBloc extends Bloc<FetchMyPostEvent, FetchMyPostState> {
  FetchMyPostBloc() : super(FetchMyPostInitial()) {
    on<FetchMyPostEvent>(
      (event, emit) async {
        emit(FetchMyPostLoadingState());
        try {
          final response = await UserRepo.fetchUserPosts();
          if (response != null && response.statusCode == 200) {
            final responseBody = response.body;
            final List<MyPostModel> posts = parsePostsFromJson(responseBody);
            emit(FetchMyPostSuccessState(posts: posts));
          } else if (response != null) {
            final responseBody = jsonDecode(response.body);
            emit(FetchMyPostErrorState(error: responseBody['message']));
          } else {
            emit(FetchMyPostErrorState(error: 'Something went wrong'));
          }
        } catch (e) {
          emit(FetchMyPostErrorState(error: 'Failed to load posts: $e'));
        }
      },
    );
    on<EditPostButtonClicked>(
      (event, emit) async {
        emit(EditUserPostLoadingState());

        final response = await PostRepo.editPost(
          description: event.description,
          postId: event.postId,
          tags: event.tags,
        );

        if (response == null) {
          emit(EditUserPostErrorState(error: 'Something went wrong'));
          return;
        }

        if (response.statusCode == 200) {
          add(FetchAllMyPostsEvent());
          emit(EditUserPostSuccessState());
        } else if (response.statusCode == 500) {
          emit(EditUserPostErrorState(error: 'Server error: ${response.body}'));
        } else {
          final responseBody = jsonDecode(response.body);
          emit(EditUserPostErrorState(
              error: responseBody['message'] ?? 'Unknown error'));
        }
      },
    );
    on<PostDeleteButtonPressedEvent>(
      (event, emit) async {
        emit(OnDeleteButtonClickedLoadingState());
        var response = await PostRepo.deletePost(event.postId);
        if (response != null && response.statusCode == 200) {
          // Re-fetch all posts after successful deletion
          add(FetchAllMyPostsEvent());
          return emit(OnDeleteButtonClickedSuccesState());
        } else if (response != null) {
          final responseBody = jsonDecode(response.body);
          return emit(
              OnDeleteButtonClickedErrrorState(error: responseBody['message']));
        } else {
          return emit(
              OnDeleteButtonClickedErrrorState(error: 'Something went wrong'));
        }
      },
    );
  }

  List<MyPostModel> parsePostsFromJson(String jsonString) {
    final List<dynamic> parsedData = jsonDecode(jsonString);
    return parsedData.map((item) => MyPostModel.fromJson(item)).toList();
  }
}
