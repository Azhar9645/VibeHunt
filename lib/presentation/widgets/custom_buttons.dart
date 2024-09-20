import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

MaterialButton loadingButton({
  required VoidCallback onPressed,
  required Color color,
}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.r), // Capsule shape
    ),
    minWidth: 0.9.sw, // Width of the button
    height: 0.06.sh, // Height of the button
    color: color,
    elevation: 6.0, // Slight shadow for a floating effect
    padding: EdgeInsets.zero, // Remove vertical padding
    child: Center(
      child: SizedBox(
        height: 30.h, // Fixed height for the loading animation container
        child: LoadingAnimationWidget.newtonCradle(
          color: Colors.white,
          size: 100.sp, // Use sp for sizing the loading animation dots
        ),
      ),
    ),
  );
}
