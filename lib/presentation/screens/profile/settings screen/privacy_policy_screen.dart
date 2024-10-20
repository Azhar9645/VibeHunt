import 'package:flutter/material.dart';
import 'package:vibehunt/utils/constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          'Privacy Policy',
          style: j24, // You can adjust this value
        ),
      ),
      body: const SingleChildScrollView(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),

            SizedBox(height: 16.0),
            Text(
              'Welcome to VibeHunt! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. Please read this policy carefully to understand our views and practices regarding your personal data and how we will treat it.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            // Information Collection
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We collect information to provide better services to our users. The types of information we collect include:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text:
                  'Personal Data: Information that you provide to us when you register, such as your name, email address, phone number, and profile picture.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text:
                  'Usage Data: Information about how you use the app, such as the features you use, the time and duration of your activities, and other interaction data.',
            ),
            SizedBox(height: 20.0),

            // Use of Information
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We use the information we collect in various ways, including to:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Provide, operate, and maintain our app.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Improve, personalize, and expand our app.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Understand and analyze how you use our app.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text:
                  'Develop new products, services, features, and functionality.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text:
                  'Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the app, and for marketing and promotional purposes.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Process your transactions and manage your orders.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Find and prevent fraud.',
            ),
            SizedBox(height: 20.0),

            // Sharing of Information
            Text(
              'Sharing of Your Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We do not share any information we collect about you with third parties.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            // Data Security
            Text(
              'Data Security',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            // Your Rights
            Text(
              'Your Rights and Choices',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Depending on where you live, you may have the following rights with respect to your personal information:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Access and update your personal information.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Request that we delete your personal information.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Opt out of marketing communications.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Restrict the processing of your personal information.',
            ),
            SizedBox(height: 16.0),
            BulletPoint(
              text: 'Object to the use of your personal information.',
            ),
            SizedBox(height: 20.0),

            // Changes to This Policy
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any changes by posting the new Privacy Policy on our app. You are advised to review this Privacy Policy periodically for any changes.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            // Contact Us
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'azhardev96@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
                color: kGreen,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16.0)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
