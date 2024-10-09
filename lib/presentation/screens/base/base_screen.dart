import 'package:flutter/material.dart';
import 'package:vibehunt/presentation/screens/add_post/bottom_sheet.dart';
import 'package:vibehunt/presentation/screens/explore/explore_screen.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/screens/chat/chat_list_screen.dart';
import 'package:vibehunt/presentation/screens/profile/profile_screen.dart';
import 'package:vibehunt/utils/constants.dart';

final ValueNotifier<int> currentPage = ValueNotifier(0);

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    ExploreScreen(),
    ChatListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Check if the keyboard is open by using MediaQuery's viewInsets
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => IndexedStack(
          index: value,
          children: pages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 56, // Reduced height to fit the content
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home
                buildNavBarItem(
                  icon: Icons.home,
                  label: 'Home',
                  index: 0,
                  value: value,
                ),
                // Boards/Search
                buildNavBarItem(
                  icon: Icons.grid_view,
                  label: 'Boards',
                  index: 1,
                  value: value,
                ),
                // Center FAB placeholder
                const SizedBox(width: 60),
                // Messages/Chat
                buildNavBarItem(
                  icon: Icons.message,
                  label: 'Messages',
                  index: 2,
                  value: value,
                ),
                // Profile
                buildNavBarItem(
                  icon: Icons.person,
                  label: 'Profile',
                  index: 3,
                  value: value,
                ),
              ],
            ),
          ),
        ),
      ),
      // Hide or show FAB based on keyboard visibility
      floatingActionButton: isKeyboardVisible
          ? null // Hide FAB when keyboard is visible
          : FloatingActionButton(
              onPressed: () {
                showCustomBottomSheet(context);
              },
              backgroundColor: kGreen,
              child: const Icon(Icons.add, size: 36),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNavBarItem({
    required IconData icon,
    required String label,
    required int index,
    required int value,
  }) {
    return GestureDetector(
      onTap: () {
        currentPage.value = index;
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24, // Reduced icon size
              color: value == index ? kGreen : Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12, // Reduced font size
                color: value == index ? kGreen : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
