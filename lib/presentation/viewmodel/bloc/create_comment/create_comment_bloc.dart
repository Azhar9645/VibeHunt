import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  CreateCommentBloc() : super(CreateCommentInitial()) {
    on<CreateCommentEvent>((event, emit) {});
    on<CommentPostButtonClickEvent>(commentPostButtonClickEvent);
  }

  FutureOr<void> commentPostButtonClickEvent(
      CommentPostButtonClickEvent event, Emitter<CreateCommentState> emit) async {
    emit(CreateCommentLoadingState());
    final Response result = await PostRepo.commentPost(
        postId: event.postId, userName: event.userName, content: event.content);
    final responseBody = jsonDecode(result.body);
    if (result.statusCode == 200) {
      emit(CreateCommentSuccessState(commentId: responseBody['commentId']));
    } else if (responseBody['status'] == 404) {
      emit(CreateCommentNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(CreateCommentErrorState());
    }
  }
}
