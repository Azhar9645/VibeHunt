part of 'edit_user_profile_bloc.dart';

@immutable
sealed class EditUserProfileEvent {}
final class OnEditProfileButtonClickedEvent extends EditUserProfileEvent{
      final String name;
  final String bio;
  final dynamic image;
  final String imageUrl;
  final dynamic bgImage;
  final String bgImageUrl;

  OnEditProfileButtonClickedEvent({required this.name, required this.bio, required this.image, required this.imageUrl, required this.bgImage, required this.bgImageUrl});
}

