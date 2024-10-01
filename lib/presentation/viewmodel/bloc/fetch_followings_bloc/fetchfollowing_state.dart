part of 'fetchfollowing_bloc.dart';

@immutable
sealed class FetchfollowingState {}

final class FetchfollowingInitial extends FetchfollowingState {}

final class FetchfollowingLoadingState extends FetchfollowingState {}

final class FetchfollowingSuccessState extends FetchfollowingState {
        final FollowingsModel following;
FetchfollowingSuccessState({required this.following});
}
final class FetchfollowingErrorState extends FetchfollowingState {}


