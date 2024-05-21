import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/widgets/followers_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(Assets.imagesMan),
                ),
                Spacer(),
                FollowersCard(
                  text: 'followers',
                ),
                Gap(10),
                FollowersCard(text: 'following'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'display name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('@username'),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: kWhiteColor,
                    elevation: 0,
                    backgroundColor: kPrimaryColor.withOpacity(0.7),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'follow',
                      ),
                      Icon(
                        Icons.add,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    foregroundColor: kWhiteColor,
                    elevation: 0,
                    backgroundColor: kPrimaryColor.withOpacity(0.7),
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.message,
                  ),
                ),
              ],
            ),
            Gap(10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Bio',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(10),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'posts',
                ),
                Tab(
                  text: 'photos',
                )
              ],
            ),
            // we must warp TabBarView with Expanded if it is inside column or Row
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: Text('posts'),
                  ),
                  Container(
                    child: Text('photos'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
