part of 'get_all_conversation_bloc.dart';

@immutable
sealed class GetAllConversationState {}

final class GetAllConversationInitial extends GetAllConversationState {}

final class GetAllConversationLoadingState extends GetAllConversationState {}

final class GetAllConversationSuccessState extends GetAllConversationState {
  final List<ConversationModel> conversations;
  final List<GetUserModel> otherUsers;
  GetAllConversationSuccessState({required this.conversations,required this.otherUsers});
}

final class GetAllConversationErrorState extends GetAllConversationState {}

