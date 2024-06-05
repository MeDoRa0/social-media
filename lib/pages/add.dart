import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/provider/user_provider.dart';
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
  uploadPost(String userID, String displayName, String userName,
      String profilePicture) async {
    try {
      String response = await CloudMethod().uploadPost(
          post: postController.text,
          userID: userID,
          dispalyName: displayName,
          userName: userName,
          profilePicture: profilePicture,
          file: file!);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('add post'),
        actions: [
          TextButton.icon(
            onPressed: () {
              uploadPost(userModel.profilePicture, userModel.displayName,
                  userModel.userName, userModel.profilePicture);
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
                Uint8List? myfile = await pickImage(context);
                if (myfile != null) {
                  setState(() {
                    file = myfile;
                  });
                }
              },
              child: Icon(
                Icons.photo,
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
