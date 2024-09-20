part of 'fetchfollowers_bloc.dart';

@immutable
sealed class FetchfollowersState {}

final class FetchfollowersInitial extends FetchfollowersState {}

final class FetchfollowersLoadingState extends FetchfollowersState {}

final class FetchfollowersSuccessState extends FetchfollowersState {
  final FollowersModel followersModel;
  FetchfollowersSuccessState({required this.followersModel});
}
final class FetchfollowersErrorState extends FetchfollowersState {}



