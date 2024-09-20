part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowEvent {}

final class OnFollowButtonClickedEvent extends FollowUnfollowEvent{
      final String followerId;

  OnFollowButtonClickedEvent({required this.followerId});
}
final class OnUnFollowButtonClickedEvent extends FollowUnfollowEvent{
      final String followerId;

  OnUnFollowButtonClickedEvent({required this.followerId});
}
