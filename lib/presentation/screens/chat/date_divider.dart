import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final DateTime date;
  const DateDivider({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              _formatDate(date),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (now.year == date.year && now.month == date.month && now.day == date.day) {
      return 'Today';
    } else if (now.year == date.year && now.month == date.month && now.day == date.day + 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
