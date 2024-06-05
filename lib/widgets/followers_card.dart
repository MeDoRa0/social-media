import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';

class FollowersCard extends StatelessWidget {
  FollowersCard({
    required this.text,
     required this.number,
    super.key,
  });
  String text;
  int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            children: [
              ImageStack(
                  imageBorderWidth: 2,
                  imageBorderColor: kWhiteColor,
                  imageRadius: 40,
                  imageSource: ImageSource.Asset,
                  imageList: const [Assets.imagesMan, Assets.imagesWoman],
                  totalCount: 0),
              Row(
                children: [
                   Text(number.toString()),
                  const Gap(5),
                  Text(text),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
