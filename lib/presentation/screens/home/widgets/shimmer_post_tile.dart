import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostTile extends StatelessWidget {
  const ShimmerPostTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[850], // Same background color as your post card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for User Profile and Name
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[700]!,
                    highlightColor: Colors.grey[500]!,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          width: 100,
                          height: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          width: 80,
                          height: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Shimmer for Post Image
              Shimmer.fromColors(
                baseColor: Colors.grey[700]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 250, // Adjust height to match actual post image
                  width: double.infinity,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              // Shimmer for Post Description
              Shimmer.fromColors(
                baseColor: Colors.grey[700]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: double.infinity,
                  height: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey[700]!,
                highlightColor: Colors.grey[500]!,
                child: Container(
                  width: 150,
                  height: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              // Shimmer for Likes, Comments, etc.
              Shimmer.fromColors(
                baseColor: Colors.grey[700]!,
                highlightColor: Colors.grey[500]!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 12,
                      color: Colors.grey[700],
                    ),
                    Container(
                      width: 60,
                      height: 12,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
