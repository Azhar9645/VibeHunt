import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerTile() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: ListTile(
      trailing: Container(
        width: 75,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100) ,
        ),
      ),
      title: Container(
        height: 16,
        width: 150,
        color: Colors.grey.shade300,
      ),
    ),
  );
}