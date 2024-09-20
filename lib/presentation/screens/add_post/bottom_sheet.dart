import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibehunt/presentation/screens/add_post/post_create_screen.dart';
import 'package:vibehunt/utils/constants.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  Future<void> _selectImageFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // After selecting the image, navigate to the PostUploadScreen and pass the image.
      Navigator.pop(context); // Close the bottom sheet
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostUploadScreen(images: pickedFile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create Post',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_library, size: 48, color: kGreen),
                    onPressed: () => _selectImageFromGallery(context),
                  ),
                  const Text('Gallery', style: TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 48, color: kGreen),
                    onPressed: () {
                      // Handle camera selection
                    },
                  ),
                  const Text('Camera', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return const CustomBottomSheet();
    },
  );
}
