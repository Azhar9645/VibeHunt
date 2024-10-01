part of 'fetch_all_following_post_bloc.dart';

@immutable
abstract class FetchAllFollowingPostEvent {}

class AllFollowingsPostsInitialFetchEvent extends FetchAllFollowingPostEvent {
  
}

class LoadMoreEvent extends FetchAllFollowingPostEvent {}

class Fetchcomments extends FetchAllFollowingPostEvent {}
