import 'package:flutter/material.dart';

class AlternativeChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Main background color
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150", // Placeholder for profile image
              ),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              "Larry Machigo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                ChatBubble(
                  text: "Hey 👋",
                  isSender: false,
                ),
                ChatBubble(
                  text: "Are you available for a New UI Project?",
                  isSender: false,
                ),
                ChatBubble(
                  text: "Hello!",
                  isSender: true,
                ),
                ChatBubble(
                  text: "Yes, have some space for the new task.",
                  isSender: true,
                ),
                ChatBubble(
                  text: "Cool, should I share the details now?",
                  isSender: false,
                ),
                ChatBubble(
                  text: "Yes Sure, please",
                  isSender: true,
                ),
                ChatBubble(
                  text: "Great, here is the SOW of the Project",
                  isSender: false,
                ),
                FileBubble(
                  fileName: "UI Brief.docx",
                  fileSize: "260.18 KB",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send, color: Colors.green),
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  ChatBubble({required this.text, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSender ? Colors.green : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: isSender ? const Radius.circular(15) : Radius.zero,
              bottomRight: isSender ? Radius.zero : const Radius.circular(15),
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black54,
                offset: Offset(2, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSender ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class FileBubble extends StatelessWidget {
  final String fileName;
  final String fileSize;

  FileBubble({required this.fileName, required this.fileSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              const BoxShadow(
                color: Colors.black54,
                offset: Offset(2, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.attach_file, color: Colors.black54),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fileName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fileSize,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
