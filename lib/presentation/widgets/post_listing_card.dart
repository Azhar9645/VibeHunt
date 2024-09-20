import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/data/models/my_post/my_post_model.dart';
import 'package:vibehunt/utils/constants.dart';

class MyPostListingPageCard extends StatelessWidget {
  final List<MyPostModel> post;
  final String profileImage;
  final String mainImage;
  final String userName;
  final String postTime;
  final String description;
  final String likeCount;
  final String commentCount;
  final VoidCallback likeButtonPressed;
  final int index;

  const MyPostListingPageCard({
    super.key,
    required this.mainImage,
    required this.profileImage,
    required this.post,
    required this.userName,
    required this.postTime,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.likeButtonPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(8.0.w), // Use .w to scale based on screen width
        child: Stack(
          children: [
            // Grey container with curved border radius
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Grey background color
                borderRadius: BorderRadius.circular(15.0.r), // Curved border radius
              ),
              padding: EdgeInsets.all(10.0.w), // Padding to create space for overlay
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main image with profile and username on top
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r), // Ensure the image fits within the container
                    child: SizedBox(
                      height: 300.0.h, // Adjust height based on screen height
                      width: 1.sw, // Use 1.sw for full screen width
                      child: Stack(
                        children: [
                          // Main image
                          CachedNetworkImage(
                            imageUrl: mainImage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                  color: kGrey1,
                                  size: 30.0.w, // Scale the loading animation
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: 30.0.sp,
                              color: kRed,
                            ), // Added error widget
                          ),
                          Positioned(
                            left: 10.0.w,
                            top: 10.0.h,
                            child: Row(
                              children: [
                                Container(
                                  height: 65.0.h, // Use .h to scale based on screen height
                                  width: 65.0.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(profileImage),
                                      fit: BoxFit.cover,
                                    ),
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(100.0.r), // Scale for border radius
                                  ),
                                ),
                                SizedBox(width: 10.0.w), // Adjust width
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0.sp, // Scale font size
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10.0.h,
                            right: 10.0.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: likeButtonPressed,
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: 30.0.sp, // Scale icon size
                                  ),
                                  color: kRed,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Add comment button functionality here
                                  },
                                  icon: Icon(
                                    Icons.mode_comment_outlined,
                                    size: 30.0.sp, // Scale icon size
                                  ),
                                  color: kWhiteColor,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Add save button functionality here
                                  },
                                  icon: Icon(
                                    Icons.bookmark_border,
                                    size: 30.0.sp, // Scale icon size
                                  ),
                                  color: kWhiteColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0.h), // Adjust spacing
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w), // Adjust padding
                    child: Text(
                      '$likeCount likes',
                      style: TextStyle(fontSize: 14.0.sp), // Scale font size
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w), // Adjust padding
                    child: Text(
                      '$commentCount comments',
                      style: TextStyle(fontSize: 14.0.sp), // Scale font size
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}