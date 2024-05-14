import 'package:flutter/material.dart';
import 'package:social_media/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondryColor,
      appBar: AppBar(),
      body: Center(
        child: Text('profile page'),
      ),
    );
  }
}
