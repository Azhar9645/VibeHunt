part of 'explore_post_bloc.dart';

@immutable
sealed class ExplorePostState {}

final class ExplorePostInitial extends ExplorePostState {}

final class ExplorePostLoadingState extends ExplorePostState {}

final class ExplorePostSuccessState extends ExplorePostState {
      final List<ExplorePostModel> posts;
      ExplorePostSuccessState({required this.posts});
}

final class ExplorePostErrorState extends ExplorePostState {}

