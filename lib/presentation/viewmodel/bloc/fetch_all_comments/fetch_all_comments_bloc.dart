import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/models/profile/comment_model.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'fetch_all_comments_event.dart';
part 'fetch_all_comments_state.dart';

class FetchAllCommentsBloc
    extends Bloc<FetchAllCommentsEvent, FetchAllCommentsState> {
  FetchAllCommentsBloc() : super(FetchAllCommentsInitial()) {
    on<FetchAllCommentsEvent>((event, emit) {});
    on<CommentsFetchEvent>(commentsFetchEvent);
  }
  FutureOr<void> commentsFetchEvent(
      CommentsFetchEvent event, Emitter<FetchAllCommentsState> emit) async {
    emit(FetchAllCommentsLoadingState());
    final Response result = await PostRepo.getAllComments(postId: event.postId);
    if (result.statusCode == 200) {
      final responseBody = jsonDecode(result.body);
      List<Comment> comments = List<Comment>.from(responseBody['comments']
          .map((commentJson) => Comment.fromJson(commentJson)));
      emit(FetchAllCommentsSuccessState(comments: comments));
    } else if (result.statusCode == 500) {
      emit(FetchAllCommentsErrorState());
    }
  }
}
