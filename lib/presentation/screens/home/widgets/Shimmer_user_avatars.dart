import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vibehunt/data/models/all_user_model.dart';

class ShimmerUserAvatars extends StatelessWidget {
  final List<AllUser>? users; // List of users or null
  final bool isLoading; // Loading state
  final VoidCallback? onSeeAllPressed; // Callback for See All button

  const ShimmerUserAvatars({
    Key? key,
    this.users,
    this.isLoading = false,
    this.onSeeAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSeeAllButton(),
        const SizedBox(height: 5),
        SizedBox(
          height: 100,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Show shimmer for 5 items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 2.0),
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 50,
                              height: 10,
                              color: Colors.grey, // Placeholder for user name
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 2.0),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(users![index].profilePic!,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            users![index].userName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSeeAllButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // TextButton(
        //   onPressed: onSeeAllPressed,
        //   child: const Row(
        //     children: [
        //       Text('See All', style: TextStyle(color: Colors.green)),
        //       SizedBox(width: 4),
        //       Icon(Icons.arrow_forward_ios, color: Colors.green, size: 16),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
