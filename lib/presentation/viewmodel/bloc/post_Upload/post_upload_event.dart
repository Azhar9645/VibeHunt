part of 'post_upload_bloc.dart';

@immutable
sealed class PostUploadEvent {}

final class OnUploadButtonClickedEvent extends PostUploadEvent {
  final String description;
  final String imagePath;
  final List<String> tags;
  final BuildContext context;
  final TextEditingController captionController;
  final TextEditingController keywordController;
  

  OnUploadButtonClickedEvent(
      {required this.description,
    required this.imagePath,
    required this.tags,
    required this.context,
    required this.captionController,
    required this.keywordController,});
}
