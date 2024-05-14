import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(),
      body: Center(child: Text('home page'),),
    );
  }
}
