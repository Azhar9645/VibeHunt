import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/my_post/my_post_model.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_post_bloc/fetch_my_post_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';
import 'package:vibehunt/utils/constants.dart';

class PostEditScreen extends StatefulWidget {
  final MyPostModel model;

  const PostEditScreen({super.key, required this.model});

  @override
  _PostEditScreenState createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _keywords = [];

  @override
  void initState() {
    super.initState();
    captionController.text = widget.model.description ?? '';

    // Convert tags from dynamic to String and initialize _keywords
    if (widget.model.tags != null) {
      _keywords.addAll(
        widget.model.tags!.map((tag) => tag.toString()).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post',
          style: j24,
        ),
      ),
      body: BlocConsumer<FetchMyPostBloc, FetchMyPostState>(
        listener: (context, state) {
          if (state is EditUserPostSuccessState) {
            customSnackbar(context, 'Update Successful', kGreen, Icons.done);
            Navigator.pop(context);
          } else if (state is EditUserPostErrorState) {
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
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kWhiteColor,
                        image: widget.model.image != null
                            ? DecorationImage(
                                image: NetworkImage(widget.model.image!),
                                fit: BoxFit.cover,
                              )
                            : null,
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
                    if (state is EditUserPostLoadingState)
                      loadingButton(onPressed: () {}, color: kGreen)
                    else
                      BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
                        builder: (context, state) {
                          if (state is EditUserPostLoadingState ||
                              state is FetchMyPostLoadingState) {
                            return loadingButton(
                                onPressed: () {}, color: kGreen);
                          }
                          return MyButton(
                            text: 'Update',
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _keywords.isNotEmpty) {
                                context.read<FetchMyPostBloc>().add(
                                      EditPostButtonClicked(
                                        description: captionController.text,
                                        tags: _keywords,
                                        postId: widget.model.id.toString(),
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please write a caption and add at least one keyword.'),
                                  ),
                                );
                              }
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
                  _removeKeyword(keyword);
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

  void _removeKeyword(String keyword) {
    setState(() {
      _keywords.remove(keyword);
    });
  }
}
