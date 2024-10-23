import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vibehunt/data/models/message_model.dart';
import 'package:vibehunt/data/models/user_profile_model.dart';
import 'package:vibehunt/data/services/web_socket/web_socket.dart';
import 'package:vibehunt/presentation/screens/chat/date_divider.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/screens/profile/follow_following_screen/user_profile_screen.dart';
import 'package:vibehunt/presentation/screens/rive_screen.dart/rive_loading.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/add_message/add_message_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/get_all_conversation.dart/get_all_conversation_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String recieverid;
  final String name;
  final String username;
  final String profilepic;

  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.recieverid,
    required this.name,
    required this.profilepic,
    required this.username,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ConversationBloc>().add(
          GetAllMessagesInitialFetchEvent(
            conversationId: widget.conversationId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: kGrey,
        elevation: 1.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: kWhiteColor,
          ),
        ),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to UserProfileScreen when avatar is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      userId: widget.recieverid,
                      user: UserIdSearchModel(
                        id: widget.recieverid,
                        userName: widget.username,
                        email: '', // Add email if available
                        profilePic: widget.profilepic,
                        phone: '', // Add phone if available
                        online:
                            false, // Set default or fetch value for online status
                        blocked:
                            false, // Set default or fetch value for blocked status
                        verified:
                            false, // Set default or fetch value for verified status
                        role: '', // Add role if available
                        isPrivate: false, // Set privacy status if available
                        backGroundImage:
                            '', // Add background image URL if available
                        createdAt: DateTime
                            .now(), // Set actual or default creation date
                        updatedAt:
                            DateTime.now(), // Set actual or default update date
                        v: 0, // Add version if necessary
                        bio: '', // Add bio if available
                        name: widget.name.isNotEmpty
                            ? widget.name
                            : 'Guest', // Add name or set a default value
                      ),
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.profilepic),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                  ),
                ),
                Text(
                  widget.name.isEmpty ? 'Guest User' : widget.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ConversationBloc, ConversationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllMessagesLoadingState) {
                    return RiveLoadingScreen();
                  }
                  if (state is GetAllMessagesSuccesfulState) {
                    List<DateTime> dates = [];
                    List<List<AllMessagesModel>> messagesByDate = [];
                    for (var message in state.messagesList) {
                      DateTime date = DateTime(message.createdAt.year,
                          message.createdAt.month, message.createdAt.day);
                      if (!dates.contains(date)) {
                        dates.add(date);
                        messagesByDate.add([message]);
                      } else {
                        messagesByDate.last.add(message);
                      }
                    }
                    dates = dates.reversed.toList();
                    messagesByDate = messagesByDate.reversed.toList();
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: dates.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            DateDivider(date: dates[index]),
                            ...messagesByDate[index]
                                .map((message) => getMessageCard(message)),
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: TextFormField(
              controller: _messageController,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGrey,
                hintText: 'Type a message...',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: GestureDetector(
            onTap: () {
              if (_messageController.text.isNotEmpty) {
                SocketService().sendMessgage(
                  _messageController.text,
                  widget.recieverid,
                  logginedUserId,
                );
                final message = AllMessagesModel(
                  id: '',
                  senderId: logginedUserId,
                  recieverId: widget.recieverid,
                  conversationId: widget.conversationId,
                  text: _messageController.text,
                  isRead: false,
                  deleteType: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  v: 0,
                );
                BlocProvider.of<ConversationBloc>(context)
                    .add(AddNewMessageEvent(message: message));
                context.read<AddMessageBloc>().add(AddMessageButtonClickEvent(
                    message: _messageController.text,
                    senderId: logginedUserId,
                    recieverId: widget.recieverid,
                    conversationId: widget.conversationId));
                context
                    .read<GetAllConversationBloc>()
                    .add(AllConversationsInitialFetchEvent());
                _messageController.clear();
              }
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: kGreen,
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getMessageCard(AllMessagesModel message) {
    bool isSender = message.senderId ==
        logginedUserId; // Check if the current user is the sender

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isSender ? kGreen : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSender ? 12 : 0),
            topRight: Radius.circular(isSender ? 0 : 12),
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
