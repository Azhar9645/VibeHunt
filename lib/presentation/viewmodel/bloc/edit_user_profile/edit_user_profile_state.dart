part of 'edit_user_profile_bloc.dart';

@immutable
sealed class EditUserProfileState {}

final class EditUserProfileInitial extends EditUserProfileState {}

final class EditUserProfileSuccesState extends EditUserProfileState {}

final class EditUserProfileErrorState extends EditUserProfileState {
  final String error;

  EditUserProfileErrorState({required this.error});
}
final class EditUserProfileLoadingState extends EditUserProfileState {}