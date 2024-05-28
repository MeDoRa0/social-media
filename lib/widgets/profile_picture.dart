import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/provider/user_provider.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return userModel.profilePicture == ''
        ? const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(Assets.imagesMan),
            //if user has profile picture display his picture
          )
        : CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(userModel.profilePicture),
          );
  }
}
