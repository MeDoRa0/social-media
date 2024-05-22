import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(Assets.imagesMan),
                ),
                const Spacer(),
                FollowersCard(
                  text: 'followers',
                ),
                const Gap(10),
                FollowersCard(text: 'following'),
              ],
            ),
            Row(
              children: [
                const Expanded(
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
                  child: const Row(
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
                    shape: const CircleBorder(),
                    foregroundColor: kWhiteColor,
                    elevation: 0,
                    backgroundColor: kPrimaryColor.withOpacity(0.7),
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.message,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
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
            const Gap(10),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'posts',
                ),
                Tab(
                  text: 'photos',
                )
              ],
            ),
            Gap(20),
            // we must warp TabBarView with Expanded if it is inside column or Row
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: const Text('posts'),
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance.collection('post').get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Text('error');
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return GridView.builder(
                          itemCount: snapshot.data.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 3,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            dynamic item = snapshot.data.docs[index];
                            return Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    item['postImage'],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
