part of 'explore_post_bloc.dart';

@immutable
sealed class ExplorePostEvent {}

final class OnFetchExplorePostsEvent extends ExplorePostEvent{}
