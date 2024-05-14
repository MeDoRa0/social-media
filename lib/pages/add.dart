import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
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
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('add post'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.post_add),
            label: const Text('Post'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imagesMan),
                ),
                Gap(30),
                Expanded(
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'type here...'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesMan),
                  ),
                ),
              ),
            ),
            Gap(30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: kPrimaryColor,
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {},
              child: Icon(
                Icons.add_a_photo,
                color: kWhiteColor,
              ),
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
