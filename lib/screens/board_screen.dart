import 'package:flutter/material.dart';
import 'package:unige_board/components/my_textfield.dart';
import 'package:unige_board/components/wall_post.dart';
import 'package:unige_board/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unige_board/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoardScreen extends StatefulWidget {
  static String id = 'board_screen';

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final _auth = FirebaseAuth.instance;
  final loggedInUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  // post message
  void postMessage() {
    // only post if there is sth in the textfield
    if (textController.text.isNotEmpty) {
      if (loggedInUser.email != null) {
        // store in firebase
        FirebaseFirestore.instance.collection("User Posts").add({
          'UserEmail': loggedInUser.email,
          'Message': textController.text,
          'TimeStamp': Timestamp.now(),
          'Participants': [],
        });
      }
    }
    // Clear the textField
    setState(() {
      textController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('BOARD'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            // the wall
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy(
                      "TimeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          participants:
                              List<String>.from(post.data()['Participants'] ?? []),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: " + snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  // Textfield
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: "Write sth on the board",
                      obscureText: false,
                    ),
                  ),

                  // Post Button
                  IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up))
                ],
              ),
            ),
            // logged in as
            Text("Logged in as: " + loggedInUser.email!),
          ],
        ),
      ),
    );
  }
}
