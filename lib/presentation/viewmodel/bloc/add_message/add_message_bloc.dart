import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:vibehunt/data/repositories/chat_repo.dart';

part 'add_message_event.dart';
part 'add_message_state.dart';

class AddMessageBloc extends Bloc<AddMessageEvent, AddMessageState> {
  AddMessageBloc() : super(AddMessageInitial()) {
    on<AddMessageEvent>((event, emit) {});
    on<AddMessageButtonClickEvent>(addMessageButtonClickEvent);
  }

  FutureOr<void> addMessageButtonClickEvent(
      AddMessageButtonClickEvent event, Emitter<AddMessageState> emit) async {
    emit(AddMessageLoadingState());
    final Response response = await ChatRepo.addMessage(
        recieverId: event.recieverId,
        text: event.message,
        conversationId: event.conversationId,
        senderId: event.senderId);
    debugPrint('add message status code-${response.statusCode}');
    if (response.statusCode == 200) {
      emit(AddMessageSuccesfulState());
    } else {
      emit(AddMessageErrorState());
    }
  }
}
