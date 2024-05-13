import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class testPage extends StatefulWidget {
  const testPage({super.key});

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(_auth.currentUser!.email.toString()),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text('signout'),
            )
          ],
        ),
      ),
    );
  }
}
