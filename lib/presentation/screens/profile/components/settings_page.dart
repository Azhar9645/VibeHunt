import 'package:flutter/material.dart';

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
          const Row(
            children: [
              Spacer(),
              Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Spacer(), // Ensure the title is centered
            ],
          ),
          const SizedBox(height: 20),
          // Edit Profile option
          ListTile(
            title: const Text('Edit Profile',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              // Add your action for editing profile
            },
          ),
          // Privacy Policy option
          ListTile(
            title: const Text('Privacy Policy',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              // Add your action for privacy policy
            },
          ),
          // Logout option
        ],
      ),
    );
  }
}
