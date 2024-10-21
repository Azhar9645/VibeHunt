import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer CommentShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[800]!,
    highlightColor: Colors.grey[700]!,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[700], // Shimmer
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 10,
                  color: Colors.grey[700], // Shimmer
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey[700], // Shimmer
                ),
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.grey[700], // Shimmer
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}