import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibehunt/presentation/screens/base/base_screen.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/post_Upload/post_upload_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';
import 'package:vibehunt/utils/constants.dart';

class PostUploadScreen extends StatefulWidget {
  final XFile images;

  const PostUploadScreen({required this.images, super.key});

  @override
  _PostUploadScreenState createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  final List<String> _keywords = [];
  final _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: j24,
        ),
      ),
      body: BlocConsumer<PostUploadBloc, PostUploadState>(
        listener: (context, state) {
          if (state is PostUploadSuccesState) {
            customSnackbar(context, 'Upload Successful', kGreen, Icons.done);
            context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());

            // Clear input fields and chips
            captionController.clear();
            keywordController.clear();
            setState(() {
              _selectedImage = null; 
              _keywords.clear(); 
            });

            // Navigate to the profile screen 
            currentPage.value = 3; 

            Navigator.of(context).pop();
          } else if (state is PostUploadErrorState) {
            customSnackbar(context, state.error, kRed, Icons.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _selectedImage != null
                        ? Container(
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: FileImage(File(_selectedImage!.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300],
                            ),
                            child: const Center(
                              child: Text(
                                'No Image Selected',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller: captionController,
                      hintText: 'Caption',
                      maxline: 2,
                    ),
                    const SizedBox(height: 20),
                    _buildKeywordInput(),
                    const SizedBox(height: 20),
                    _buildChips(),
                    const SizedBox(height: 20),
                    BlocBuilder<PostUploadBloc, PostUploadState>(
                      builder: (context, state) {
                        if (state is PostUploadLoadingState) {
                          return loadingButton(onPressed: () {}, color: kGreen);
                        }
                        return MyButton(
                          text: 'Upload',
                          onPressed: () async {
                            _uploadPost(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKeywordInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.black),
            controller: keywordController,
            decoration: InputDecoration(
              hintText: 'Enter keywords',
              hintStyle: jStyleHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: _addKeyword,
            style: ElevatedButton.styleFrom(
              backgroundColor: kGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Icon(
              Icons.add,
              size: 30,
              color: kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChips() {
    return _keywords.isNotEmpty
        ? Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: _keywords.map((keyword) {
              return Chip(
                label: Text(
                  keyword,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.white),
                deleteIconColor: Colors.white,
                onDeleted: () {
                  setState(() {
                    _keywords.remove(keyword);
                  });
                },
              );
            }).toList(),
          )
        : Center(
            child: Text(
              'No keywords added',
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          );
  }

  void _addKeyword() {
    final keyword = keywordController.text.trim();
    if (keyword.isNotEmpty) {
      setState(() {
        _keywords.add(keyword);
      });
      keywordController.clear();
    }
  }

  void _uploadPost(BuildContext context) {
    if (_formKey.currentState!.validate() && _keywords.isNotEmpty) {
      context.read<PostUploadBloc>().add(
            OnUploadButtonClickedEvent(
              imagePath: _selectedImage?.path ?? '',
              description: captionController.text,
              tags: _keywords,
              context: context,
              captionController: captionController,
              keywordController: keywordController,
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please select an image, write a caption, and add keywords.'),
        ),
      );
    }
  }
}
