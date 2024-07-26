import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;

  const WallPost({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          // Message and user email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(color: Color(0xff424245)),
              ),
              const SizedBox(height: 10),
              Text(message)
            ],
          )
        ],
      ),
    );
  }
}
