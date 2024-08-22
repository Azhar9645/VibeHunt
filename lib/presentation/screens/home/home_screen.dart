import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // To match the top bar color
      body: SafeArea(
        child: Column(
          children: [
            // Top Profile Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User Greeting
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, AZHAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Share Your Moments \nand Connect with Friends!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Notifications and Settings
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Story Section
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 16.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStoryAvatar('Samera', 'assets/images/samera.jpg'),
                  _buildStoryAvatar('Julien', 'assets/images/julien.jpg'),
                  _buildStoryAvatar('Mariane', 'assets/images/mariane.jpg'),
                  _buildStoryAvatar('Dhinu', 'assets/images/dhinu.jpg'),
                ],
              ),
            ),

            // Feed Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildPostCard(
                      userName: 'Claire Dangais',
                      userHandle: '@ClaireD15',
                      postImage: 'assets/images/sunset.jpg',
                      likes: 122,
                      comments: 10,
                    ),
                    _buildPostCard(
                      userName: 'Farita Smith',
                      userHandle: '@SmithFa',
                      postImage: 'assets/images/abstract.jpg',
                      likes: 98,
                      comments: 7,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryAvatar(String name, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPostCard({
    required String userName,
    required String userHandle,
    required String postImage,
    required int likes,
    required int comments,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.grey[900],
        child: Column(
          children: [
            // Post Header
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              title: Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                userHandle,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            // Post Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(postImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Post Actions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        likes.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.comment,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        comments.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Icon(
                    FontAwesomeIcons.share,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
