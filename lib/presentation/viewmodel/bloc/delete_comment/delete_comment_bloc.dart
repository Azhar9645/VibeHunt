import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';

part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  DeleteCommentBloc() : super(DeleteCommentInitial()) {
    on<DeleteCommentEvent>((event, emit) {});
    on<DeleteCommentButtonClickEvent>(deleteCommentButtonClickEvent);
  }

  FutureOr<void> deleteCommentButtonClickEvent(
      DeleteCommentButtonClickEvent event,
      Emitter<DeleteCommentState> emit) async {
    emit(DeleteCommentLoadingState());
    final Response result =
        await PostRepo.deleteComment(commentId: event.commentId);
    final responseBody = jsonDecode(result.body);
    if (result.statusCode == 200) {
      emit(DeleteCommentSuccesfulState(commentId: event.commentId));
    } else if (responseBody['status'] == 404) {
      emit(DeleteCommentCommentNotFoundState());
    } else if (responseBody['status'] == 500) {
      emit(DeleteCommentServerErrorState());
    }
  }
}
