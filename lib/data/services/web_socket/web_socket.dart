import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/message_model.dart';
import 'package:vibehunt/main.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:vibehunt/presentation/viewmodel/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:vibehunt/utils/funtions.dart';


class SocketService {
  io.Socket socket = io.io(
    'https://azhar11.online', // Update with the WebSocket URL
        // 'api.azhar11.online', // Update with the WebSocket URL

    io.OptionBuilder()
        .setTransports(['websocket']) // Ensure WebSocket is used
        .disableAutoConnect()
        .build(),
  );

  void connectSocket({required BuildContext context}) async {
    final BuildContext? ctx = NavigationService.navigatorKey.currentContext;

    if (socket.disconnected) {
      socket.connect();

      socket.off("getMessage");

      socket.on("getMessage", (data) {
        debugPrint('inside get message - ${data['text']}');
        final message = AllMessagesModel(
          id: '',
          senderId: data['senderId'],
          recieverId: data['recieverId'],
          conversationId: '',
          text: data['text'],
          isRead: false,
          deleteType: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 0,
        );

        if (ctx != null) {
          ctx
              .read<ConversationBloc>()
              .add(AddNewMessageEvent(message: message));
        }
        context
            .read<ConversationBloc>()
            .add(AddNewMessageEvent(message: message));
      });
    }

    socket.onConnect((data) {
      debugPrint('Connection established');
    });
    socket.onConnectError((data) => debugPrint('connect error:$data'));
    socket.onDisconnect((data) => debugPrint('Socket.IO server disconnected'));

    final id = await getUserId();

    socket.emit("addUser", id);
  }

  sendMessgage(String message, String receiverId, String senderId) {
    socket.emit('sendMessage', {
      "senderId": senderId,
      "recieverId": receiverId,
      "text": message,
    });
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.clearListeners();
  }
}
