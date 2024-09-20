part of 'fetchfollowers_bloc.dart';

@immutable
sealed class FetchfollowersEvent {}

final class OnfetchAllFollowersEvent extends FetchfollowersEvent{}
