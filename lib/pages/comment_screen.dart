import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/widgets/custom_textfield.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(Assets.imagesMan),
                            ),
                            Gap(10),
                            Text('name'),
                          ],
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: Text('comment comment'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(10),
          Row(
            children: [
              Gap(10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'comment here..',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondryColor, shape: CircleBorder()),
                onPressed: () {},
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: kWhiteColor,
                ),
              ),
              Gap(10),
            ],
          ),
          Gap(10),
        ],
      ),
    );
  }
}
