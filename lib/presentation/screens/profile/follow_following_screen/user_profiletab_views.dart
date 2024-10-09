import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vibehunt/presentation/screens/rive_screen.dart/rive_loading.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/fetch_users_post/fetch_users_post_bloc.dart';
import 'package:vibehunt/utils/constants.dart';

class UsersProfileTabViews extends StatelessWidget {
  UsersProfileTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Headline
          Text(
            'Posts', // Your headline text
            style: j24
          ),
          const SizedBox(height: 10), // Spacing between the headline and content
          Expanded(
            child: const _UploadTabView(), // Display the post view directly
          ),
        ],
      ),
    );
  }
}

class _UploadTabView extends StatelessWidget {
  const _UploadTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchUsersPostBloc, FetchUsersPostState>(
      builder: (context, state) {
        if (state is FetchUsersPostLoadingState) {
          return const Center(
            child: RiveLoadingScreen(),
          );
        } else if (state is FetchUsersPostSuccessState) {
          final posts = state.posts;

          if (posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          return MasonryGridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            shrinkWrap: true,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (context.read<FetchUsersPostBloc>().state
                            is FetchUsersPostSuccessState) {
                          // Add your navigation logic here if necessary
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          post.image ?? '', // Assuming post has imageUrl field
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              height: 200,
                              width: double.infinity,
                              child: const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              );
            },
          );
        } else if (state is FetchUsersPostErrorState) {
          return Center(
            child: const Text('Failed to load posts'),
          );
        } else {
          return const Center(child: Text('No posts found'));
        }
      },
    );
  }
}
