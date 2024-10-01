part of 'fetchfollowing_bloc.dart';

@immutable
sealed class FetchfollowingEvent {}

final class OnFetchFollowingUsersEvent extends FetchfollowingEvent{}