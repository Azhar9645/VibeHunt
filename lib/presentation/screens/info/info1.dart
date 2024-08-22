import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen1 extends StatelessWidget {
  const InfoScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/logo/vibehunt logo.png', // Replace with your logo image path
              height: 120,
              width: 120,
            ),
          ),
          const SizedBox(height: 40), // Space between logo and text
          // Centered text
          Text(
            'Explore trends,\nconnect with millions globally.',
            textAlign: TextAlign.center,
            style: GoogleFonts.jost(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 40), // Space between text and button
          // Centered button
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           InfoScreen2()), // Replace NextScreen with your target screen
              // );
            },
            child: Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                color: Color(0xFF28A745), // Customize button color
                shape: BoxShape.circle, // Make it circular
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
