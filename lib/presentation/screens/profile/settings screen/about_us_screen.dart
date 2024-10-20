import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibehunt/utils/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          'About Us',
          style: j24, // You can adjust this value
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            Text(
              'Welcome to VibeHunt!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            // Mission Statement
            Text(
              'In a world where staying connected has never been more important, VibeHunt is here to make social interaction more vibrant, personal, and effortless. Our Flutter-powered app is designed to bring people together, fostering connections and building communities through seamless communication and engaging experiences.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Mission Title
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            // Mission Text
            Text(
              'At VibeHunt, we believe in the power of meaningful connections. Our mission is to create a platform where everyone can freely express themselves, share their moments, and connect with like-minded individuals. Whether you’re catching up with old friends or making new ones, VibeHunt is here to ensure your social journey is as lively and enjoyable as possible.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // What We Offer
            Text(
              'What We Offer',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '- Dynamic Social Interaction: Engage with friends and communities through our intuitive and feature-rich interface.\n'
              '- Real-time Communication: Enjoy seamless chatting, photo sharing, and more, all in real-time.\n'
              '- Personalized Experience: Tailor your VibeHunt experience with customizable profiles, themes, and content preferences.\n'
              '- Secure and Private: Your data security is our priority. We provide robust privacy settings and data protection to ensure your information is safe and secure.\n'
              '- Community Building: Join or create groups and communities that resonate with your interests and passions.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Why Choose VibeHunt
            Text(
              'Why Choose VibeHunt?',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'VibeHunt is not just another social media app; it’s a space designed to enhance the way you connect. Built with the latest Flutter technology, our app promises a smooth and responsive user experience. We are constantly innovating, bringing new features and improvements to make your social interactions more enjoyable and engaging.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Our Journey
            Text(
              'Our Journey',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Founded by a team of passionate developers and social media enthusiasts, VibeHunt was born out of a desire to transform the digital social landscape. We saw the need for a platform that not only connects people but also enriches their lives through meaningful interactions. Our journey is driven by your stories, your connections, and your experiences.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Join Us
            Text(
              'Join Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Be a part of the VibeHunt community! Download our app today and start exploring a world where your social life buzzes with excitement and possibility.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Contact Us
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'We’d love to hear from you! If you have any questions, feedback, or suggestions, feel free to reach out to us at support@vibehunt.com',
              style: TextStyle(fontSize: 16.0),
            ),
            // Center(
            //   child: Image.asset(appBarLogo, width: media.width * 0.4),
            // ),
          ],
        ),
      ),
    );
  }
}

// class SocialIcon extends StatelessWidget {
//   final IconData icon;
//   final String url;

//   const SocialIcon({super.key, required this.icon, required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(icon, size: 32.0, color: Colors.blueAccent),
//       onPressed: () {
//         launchUrl(Uri.parse(url));
//       },
//     );
//   }
// }
