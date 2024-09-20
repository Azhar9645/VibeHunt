import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'package:vibehunt/presentation/screens/base/base_screen.dart';
import 'package:vibehunt/presentation/screens/login/signin.dart';
import 'package:vibehunt/utils/constants.dart'; // Ensure you have kGreen defined here

class InfoScreen1 extends StatefulWidget {
  InfoScreen1({super.key});

  @override
  _InfoScreen1State createState() => _InfoScreen1State();
}

class _InfoScreen1State extends State<InfoScreen1>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  late AnimationController _rotationController;

  bool? _userLoggedIn; // To track login status

  @override
  void initState() {
    checkUserLogin(context); // Check login status
    super.initState();

    // Logo Animation
    _logoController = AnimationController(
      duration: const Duration(seconds: 3), // Set duration to 3 seconds
      vsync: this,
    )..forward(); // Start the animation

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Rotation Animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3), // Set duration for rotation
      vsync: this,
    )..repeat(); // Continuous rotation

    // Stop rotation after 3 seconds
    Timer(const Duration(seconds: 3), () {
      _rotationController.stop();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h), // Space between logo and text

            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating PNG in the background
                  RotationTransition(
                    turns: _rotationController,
                    child: Image.asset(
                      'assets/logo/logo_outer.png', // Replace with your rotating image path
                      width: 350,
                      height: 350,
                    ),
                  ),
                  // Animated logo in the center
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Opacity(
                          opacity: _logoOpacityAnimation.value,
                          child: Image.asset(
                            'assets/logo/vibehunt logo.png', // Replace with your logo image path
                            width: 200,
                            height: 200,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // Space between logo and text
            const Text(
              'Explore trends,\nconnect with \nmillions globally.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60.h),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _userLoggedIn == true
                  ? Lottie.asset(
                      'assets/lottie/0HdkvC8ByY.json', // Replace with your Lottie animation path
                      width: 200,
                      height: 200,
                    )
                  : SlideAction(
                      text: "Slide to Explore",
                      textStyle: j24,
                      innerColor: Colors.white,
                      outerColor: kGreen,
                      sliderButtonIcon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      onSubmit: () {
                        if (_userLoggedIn == null || !_userLoggedIn!) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => BaseScreen()),
                          );
                        }
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkUserLogin(context) async {
    final preferences = await SharedPreferences.getInstance();
    final userLoggedIn = preferences.getBool(authKey);

    setState(() {
      _userLoggedIn = userLoggedIn; // Update login status
    });

    await Future.delayed(const Duration(seconds: 3)); // Splash screen duration

    if (userLoggedIn == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BaseScreen()),
      );
    }
  }
}
