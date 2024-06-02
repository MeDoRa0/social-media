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
import 'package:social_media/widgets/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Uint8List? file;
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    TextEditingController displayCont = TextEditingController();
    TextEditingController bioCont = TextEditingController();
    TextEditingController userCon = TextEditingController();
    displayCont.text = userModel.displayName;
    userCon.text = userModel.userName;
    bioCont.text = userModel.bio;
    update() async {
      try {
        String response = await CloudMethod().editProfile(
          userID: userModel.userID,
          displayName: displayCont.text,
          userName: userCon.text,
          bio: bioCont.text,
          file: file,
        );
        if (response == 'success') {
          Navigator.pop(context);
        }
      } on Exception catch (e) {
        // TODO
      }
      //this to make new data display after update data in profile
      Provider.of<UserProvider>(context, listen: false).getDetails();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('edit profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Gap(20),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    file == null
                        ? const CircleAvatar(
                            backgroundImage: AssetImage(Assets.imagesMan),
                            radius: 70,
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(file!),
                          ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: kSecondryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          Uint8List _file = await pickImage();
                          setState(() {
                            file = _file;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              CustomTextfield(
                controller: displayCont,
                labelText: 'display name',
                icon: Icons.person,
              ),
              const Gap(20),
              CustomTextfield(
                controller: bioCont,
                labelText: 'bio',
                icon: Icons.info,
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondryColor,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        update();
                      },
                      child: Text(
                        'update',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
