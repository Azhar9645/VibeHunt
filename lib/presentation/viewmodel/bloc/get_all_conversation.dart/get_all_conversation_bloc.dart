import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vibehunt/data/models/conversation_model.dart';
import 'package:vibehunt/data/models/get_users_chat_model.dart';
import 'package:vibehunt/data/repositories/chat_repo.dart';
import 'package:vibehunt/data/repositories/user_repo.dart';
import 'package:vibehunt/utils/funtions.dart';

part 'get_all_conversation_event.dart';
part 'get_all_conversation_state.dart';

class GetAllConversationBloc
    extends Bloc<GetAllConversationEvent, GetAllConversationState> {
  GetAllConversationBloc() : super(GetAllConversationInitial()) {
    on<GetAllConversationEvent>((event, emit) {});
    on<AllConversationsInitialFetchEvent>(allConversationsInitialFetchEvent);
  }

  FutureOr<void> allConversationsInitialFetchEvent(
      AllConversationsInitialFetchEvent event,
      Emitter<GetAllConversationState> emit) async {
    emit(GetAllConversationLoadingState());
    final userid = await getUserId();

    ChatRepo chatRepo = ChatRepo();
    
    final Response response = await chatRepo.getAllConversations();
    debugPrint('conversation fetch statuscode is-${response.statusCode}');
    debugPrint('fetchall conversations body is -${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> conversationsData = responseData['data'];

      final List<ConversationModel> conversations = conversationsData
          .map((conversationJson) =>
              ConversationModel.fromJson(conversationJson))
          .toList();
      final List<String> otherUserIds = conversations
          .expand((conversation) => conversation.members)
          .where((userId) => userId != userid)
          .toList();

      List<GetUserModel> otherUsers = [];

      for (String userId in otherUserIds) {
        final Response userResponse =
            await UserRepo.getSingleUser(userid: userId);
        if (userResponse.statusCode == 200) {
          final Map<String, dynamic> userJson = jsonDecode(userResponse.body);
          final GetUserModel user = GetUserModel.fromJson(userJson);
          otherUsers.add(user);
        }
      }
      // users.addAll(otherUsers);

      if (otherUsers.length == otherUserIds.length) {
        emit(GetAllConversationSuccessState(
          conversations: conversations,
          otherUsers: otherUsers,
          // filteredUsers: otherUsers,
        ));
      } else {
        emit(GetAllConversationErrorState());
      }
    } else {
      emit(GetAllConversationErrorState());
    }
  }
}
