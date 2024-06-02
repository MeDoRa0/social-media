import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/services/firestore_cloud.dart';

class CommentScreen extends StatefulWidget {
  final postID;
  const CommentScreen({super.key, required this.postID});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentCont = TextEditingController();
  postComment(
    String userID,
    String profilePicture,
    String displayName,
    String userName,
  ) async {
    String response = await CloudMethod().commentToPost(
      postID: widget.postID,
      userID: userID,
      commentText: commentCont.text,
      profilePicture: profilePicture,
      displayName: displayName,
      userName: userName,
    );
    if (response == 'success') {
      setState(() {
        commentCont.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              //this code to get comments
              stream: FirebaseFirestore.instance
                  .collection('post')
                  .doc(widget.postID)
                  .collection('comments')
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    dynamic data = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data['profilePicture']),
                                ),
                                const Gap(10),
                                Text(data['displayName']),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(data['commentText']),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Gap(10),
          Row(
            children: [
              const Gap(10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor),
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: commentCont,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'comment here..',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondryColor,
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  postComment(
                    userModel.userID,
                    userModel.profilePicture,
                    userModel.displayName,
                    userModel.userName,
                  );
                },
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: kWhiteColor,
                ),
              ),
              const Gap(10),
            ],
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
