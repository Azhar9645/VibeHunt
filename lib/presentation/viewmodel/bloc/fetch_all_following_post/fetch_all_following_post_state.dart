part of 'fetch_all_following_post_bloc.dart';

@immutable
abstract class FetchAllFollowingPostState {}

class FetchAllFollowingPostInitial extends FetchAllFollowingPostState {}

class FetchAllFollowingPostLoading extends FetchAllFollowingPostState {}

class FetchAllFollowingPostSuccess extends FetchAllFollowingPostState {
  final List<FollowingPostModel> posts;
 
  FetchAllFollowingPostSuccess({required this.posts});
}
class FetchAllFollowingPostErrorState extends FetchAllFollowingPostState {
  final String error;
  FetchAllFollowingPostErrorState({required this.error});
}

class FetchMorePostLoadingState extends FetchAllFollowingPostState {}

class FetchMorePostSuccessState extends FetchAllFollowingPostState {
  final List<FollowingPostModel> posts;
  FetchMorePostSuccessState({required this.posts});
}
class FetchMorePostErrorState extends FetchAllFollowingPostState {}

