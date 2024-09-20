import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vibehunt/utils/constants.dart';

class RiveLoadingScreen extends StatelessWidget {
  const RiveLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBlackColor,
      body: Center(
        child: RiveAnimation.asset(
          'assets/rive/loading_01.riv', // Path to your Rive file
          fit: BoxFit.cover, // Ensures the animation fits the entire screen
          animations: ['loading'], // The name of the animation to play
        ),
      ),
    );
  }
}
