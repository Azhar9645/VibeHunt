import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibehunt/presentation/screens/base/base_screen.dart';
import 'package:vibehunt/presentation/screens/login/signin.dart';
import 'package:vibehunt/presentation/screens/profile/components/confirmation_dialog.dart';
import 'package:vibehunt/presentation/screens/profile/components/custom_buttons/logoutConfirmationDialog.dart';
import 'package:vibehunt/presentation/screens/profile/components/settings_page.dart';
import 'package:vibehunt/presentation/screens/profile/components/showdialogue.dart';
import 'package:vibehunt/utils/funtions.dart';

class ProfileOptionsBottomSheet extends StatelessWidget {
  const ProfileOptionsBottomSheet({Key? key}) : super(key: key);

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
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Spacer(),
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
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return SettingsBottomSheet();
                },
              );
            },
          ),
          ListTile(
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () async {
              logoutConfirmationDialog(
                context: context,
                title: 'Log out!',
                content: 'Are you sure you want to log out?',
                confirmButtonText: "Yes",
                cancelButtonText: "No",
                onConfirm: () async {
                  // Perform your logout operations here
                  await clearUserSession();
                  await googleSignOut();

                  // Reset the current page
                  currentPage.value = 0;

                  // Navigate to login screen and remove all previous routes
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
