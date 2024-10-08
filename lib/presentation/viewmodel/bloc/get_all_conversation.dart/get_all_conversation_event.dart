part of 'get_all_conversation_bloc.dart';

@immutable
sealed class GetAllConversationEvent {}

class AllConversationsInitialFetchEvent extends GetAllConversationEvent {}

class SearchConversationsEvent extends GetAllConversationEvent {
  final String query;

  SearchConversationsEvent({required this.query});
}