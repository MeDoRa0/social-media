import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/widgets/custom_textfield.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                ),
              ),
              Gap(20),
              CustomTextfield(
                labelText: 'display name',
                icon: Icons.person,
              ),
              Gap(20),
              CustomTextfield(
                labelText: 'bio',
                icon: Icons.info,
              ),
              Gap(20),
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
                      onPressed: () {},
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
