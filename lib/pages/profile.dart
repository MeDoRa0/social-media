import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/pages/edit_profile.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/services/firestore_cloud.dart';
import 'package:social_media/widgets/followers_card.dart';
import 'package:social_media/widgets/post_card.dart';
import 'package:social_media/widgets/profile_picture.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    super.key,
    this.userID,
  });

  String? userID;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  String currentUserID = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    widget.userID = widget.userID ?? FirebaseAuth.instance.currentUser!.uid;
    Provider.of<UserProvider>(context, listen: false).getDetails();
    getUserData();
    super.initState();
  }

  var userInfo = {};
  bool isload = true;
  bool isFollowing = false;
  getUserData() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      userInfo = userData.data()!;
      isFollowing =
          (userData.data()! as dynamic)['followers'].contains(currentUserID);
      setState(() {
        isload = false;
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return isload
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: userInfo['userID'] == currentUserID
                ? AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  )
                : AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const ProfilePic(),
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
                      Expanded(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            userInfo['displayName'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('@' + userModel.userName),
                        ),
                      ),
                      //if this is the current user, dont show follow nor message, if not, show follow and message
                      userInfo['userID'] == currentUserID
                          ? Container()
                          : Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: kWhiteColor,
                                    elevation: 0,
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.7),
                                  ),
                                  onPressed: () {
                                    try {
                                      CloudMethod().followUser(
                                          currentUserID, userInfo['userID']);
                                      setState(() {
                                        isFollowing = !isFollowing;
                                      });
                                    } on Exception catch (e) {
                                      // TODO
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(isFollowing ? 'unfollow' : 'follow'),
                                      isFollowing
                                          ? Icon(Icons.remove)
                                          : Icon(
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
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.7),
                                  ),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.message,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  const Gap(10),
                  userInfo['bio'] == ''
                      ? Container()
                      : Row(
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
                                    userInfo['bio'],
                                    style: TextStyle(
                                        color: kPrimaryColor, fontSize: 16),
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
                  const Gap(20),
                  // we must warp TabBarView with Expanded if it is inside column or Row
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        FutureBuilder(
                          //to get all post of this user
                          future: FirebaseFirestore.instance
                              .collection('post')
                              .where('userID', isEqualTo: userInfo['userID'])
                              .get(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return const Text('error');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                itemCount: snapshot.data.docs.length == 0
                                    ? 1
                                    : snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  dynamic item = snapshot.data.docs.length == 0
                                      ? ''
                                      : snapshot.data.docs[index];
                                  return snapshot.data.docs.length == 0
                                      ? Center(
                                          child: Text('no post'),
                                        )
                                      : PostCard(item: item);
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        FutureBuilder(
                          //to get all photos of this user
                          future: FirebaseFirestore.instance
                              .collection('post')
                              .where('userID', isEqualTo: userInfo['userID'])
                              .get(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return const Text('error');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GridView.builder(
                                itemCount: snapshot.data.docs.length == 0
                                    ? 1
                                    : snapshot.data.docs.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 3,
                                        crossAxisSpacing: 3,
                                        crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  dynamic item = snapshot.data.docs.length == 0
                                      ? ''
                                      : snapshot.data.docs[index];

                                  return snapshot.data.docs.length == 0
                                      ? Text('no photos')
                                      : Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
