import 'package:flutter/material.dart';
import 'package:social_media/colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: kSecondryColor,
      appBar: AppBar(),
      body: Center(
        child: Text('add page'),
      ),
    );
  }
}
