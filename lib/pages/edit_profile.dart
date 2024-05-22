import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            Center(
                child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.imagesMan),
                  radius: 70,
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
