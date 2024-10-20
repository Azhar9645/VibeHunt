import 'package:flutter/material.dart';
import 'package:vibehunt/presentation/screens/profile/settings%20screen/about_us_screen.dart';
import 'package:vibehunt/presentation/screens/profile/settings%20screen/privacy_policy_screen.dart';
import 'package:vibehunt/presentation/screens/profile/settings%20screen/terms_and_condition_screen.dart';
import 'package:vibehunt/utils/constants.dart';

class SettingsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Spacer(),
              Text('Settings', style: j24),
              Spacer(), // Ensure the title is centered
            ],
          ),
          const SizedBox(height: 10),
          // Edit Profile option
          ListTile(
            leading: const Icon(Icons.receipt_long, color: kGreen),
            title: const Text('Terms and conditions',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndConditionScreen(),
                ),
              );
            },
          ),
          // Privacy Policy option
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined, color: kGreen),
            title: const Text('Privacy Policy',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          // Logout option
          ListTile(
            leading: const Icon(Icons.info_outline, color: kGreen),
            title:
                const Text('About us', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('VibeHunt Version 1.0.4',
                style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
