import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/services/firestore_cloud.dart';
import 'package:social_media/utils/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Uint8List? file;
  TextEditingController postController = TextEditingController();
  uploadPost() async {
    try {
      String response = await CloudMethod().uploadPost(
          post: postController.text,
          userID: 'xBbiloH0hMepa2m19oHxxQQiw0N2',
          dispalyName: 'mohamed',
          userName: 'MeDoRa',
          file: file!);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('add post'),
        actions: [
          TextButton.icon(
            onPressed: () {
              uploadPost();
            },
            icon: const Icon(Icons.post_add),
            label: const Text('Post'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(Assets.imagesMan),
                ),
                const Gap(30),
                Expanded(
                  child: TextField(
                    controller: postController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'type here...'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: file == null
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: MemoryImage(file!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            const Gap(30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () async {
                Uint8List myfile = await pickImage();
                setState(() {
                  file = myfile;
                });
              },
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
