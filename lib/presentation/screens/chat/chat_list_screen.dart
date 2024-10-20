import 'dart:async';

import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/conversation_model.dart';
import 'package:vibehunt/data/models/get_users_chat_model.dart';
import 'package:vibehunt/presentation/screens/chat/chat_screen.dart';
import 'package:vibehunt/presentation/screens/explore/components/secondary_search_field.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_conversation.dart/get_all_conversation_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController searchController = TextEditingController();
  List<GetUserModel> filteredUsers = [];
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    context
        .read<GetAllConversationBloc>()
        .add(AllConversationsInitialFetchEvent());
  }

  Future<void> refresh() async {
    final fetchBloc = context.read<GetAllConversationBloc>();
    final completer = Completer<void>();

    fetchBloc.add(AllConversationsInitialFetchEvent());
    fetchBloc.stream.listen((state) {
      if (state is GetAllConversationSuccessState) {
        completer.complete();
      }
    });

    await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message', style: j24)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SecondarySearchField(
              controller: searchController,
              onTextChanged: (String value) {
                setState(() {
                  searchQuery = value;
                });
              },
              onTap: () {},
            ),
          ),
          Expanded(
            child: CustomMaterialIndicator(
              onRefresh: refresh,
              child:
                  BlocBuilder<GetAllConversationBloc, GetAllConversationState>(
                builder: (context, state) {
                  if (state is GetAllConversationLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetAllConversationSuccessState) {
                    final conversations = state.conversations;
                    final users = state.otherUsers;

                    filteredUsers = users.where((user) {
                      return user.userName.contains(searchQuery ?? '');
                    }).toList();

                    if (filteredUsers.isEmpty) {
                      return const Center(child: Text('No chat found!'));
                    }

                    return ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final conversation = conversations[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  username: user.userName,
                                  recieverid: user.id,
                                  name: user.userName,
                                  profilepic: user.profilePic,
                                  conversationId: conversation.id,
                                ),
                              ),
                            );
                          },
                          child: _buildChatListItem(
                            profileImageUrl: user.profilePic,
                            username: user.userName,
                            messagePreview: conversation.lastMessage ?? '',
                            messageTime: '12:00 PM', // Placeholder
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListItem({
    required String profileImageUrl,
    required String username,
    required String messagePreview,
    required String messageTime,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  messagePreview,
                  style: TextStyle(color: Colors.grey[400]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageTime,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
