import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unige_board/components/participate_button.dart';
import 'package:unige_board/screens/participants_list.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> participants;

  const WallPost(
      {super.key,
      required this.message,
      required,
      required this.postId,
      required this.participants,
      required this.user});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // user
  final loggedInUser = FirebaseAuth.instance.currentUser!;
  bool isParticipate = false;

  @override
  void initState() {
    super.initState();
    isParticipate = widget.participants.contains(loggedInUser.email);
  }

  // toggle participate
  void toggleParticipate() {
    setState(() {
      isParticipate = !isParticipate;
    });

    // access the document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isParticipate) {
      // Add user email to the list if wishes
      postRef.update({
        'Participants': FieldValue.arrayUnion([loggedInUser.email]),
      });
    } else {
      // Remove the user if changed mind
      postRef.update({
        'Participants': FieldValue.arrayRemove([loggedInUser.email]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 50),
              child: Column(
                children: [
                  // participate button
                  ParticipateButton(
                      isParticipate: isParticipate, onTap: toggleParticipate),
      
                  const SizedBox(
                    height: 5,
                  ),
      
                  // participate count
                  Text(widget.participants.length.toString()),
                ],
              ),
            ),
            // Message and user email

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user,
                      style: TextStyle(color: Color(0xff424245), fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                
                    Text(widget.message, style: TextStyle(color: Colors.white, fontSize: 12))
                
                  ],
                ),
              ),

            // show participants

            // Spacer(),
            // Flexible(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text(
            //         'Participants',
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            //       ),
            //       Text(widget.participants.join("\n"),
            //           textAlign: TextAlign.start,
            //           style: TextStyle(color: Colors.purple, fontSize: 12)),
            //     ],
            //   ),
            // )

      
          ],
        ),
      ),
    );
  }
}
