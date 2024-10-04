import 'package:flutter/material.dart';
import 'package:vibehunt/utils/constants.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Number of chats
              itemBuilder: (context, index) {
                return _buildChatListItem(
                  context: context, // Pass context to handle navigation
                  profileImageUrl:
                      'https://example.com/profile_image', // Replace with actual image URL
                  username: 'User $index',
                  messagePreview: 'This is a message preview',
                  messageTime: '12:00 PM',
                  isUnread: index % 2 == 0, // Example condition for unread
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1C1C1E),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildChatListItem({
    required BuildContext context, // Add context for navigation
    required String profileImageUrl,
    required String username,
    required String messagePreview,
    required String messageTime,
    required bool isUnread,
  }) {
    return InkWell(
      onTap: () {
        // Navigate to the MessageScreen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MessagingScreen(),
        //   ),
        // );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: kGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey[600],
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    messagePreview,
                    style: TextStyle(
                      color: isUnread ? Colors.white : Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  messageTime,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                if (isUnread)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
