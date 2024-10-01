part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}

final class LikeLoadingState extends LikeUnlikeState {}

final class AlreadyLikedState extends LikeUnlikeState {}

final class LikeSuccessState extends LikeUnlikeState {}

final class LikeNotFoundState extends LikeUnlikeState {}

final class LikeErrorState extends LikeUnlikeState {}

final class UnlikeLoadingState extends LikeUnlikeState {}

final class UnlikeErrorState extends LikeUnlikeState {}

final class UnlikeSuccessState extends LikeUnlikeState {}

final class UserNotLikedState extends LikeUnlikeState {}

final class UnlikeNotFoundState extends LikeUnlikeState {}

