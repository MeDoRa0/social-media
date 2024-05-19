import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/widgets/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //to read data from firebase
    CollectionReference posts = FirebaseFirestore.instance.collection('post');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Me',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Do',
                style: TextStyle(
                    fontSize: 26,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: FutureBuilder(
          future: posts.get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              dynamic data = snapshot.data!;

              return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  dynamic item = data.docs[index];
                  return PostCard(item: item);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
