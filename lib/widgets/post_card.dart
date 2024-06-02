import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/models/user_model.dart';
import 'package:social_media/pages/comment_screen.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/services/firestore_cloud.dart';

class PostCard extends StatefulWidget {
  final item;
  const PostCard({super.key, required this.item});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int cmmentCount = 0;
  getCommentCount() async {
    try {
      QuerySnapshot comment = await FirebaseFirestore.instance
          .collection('post')
          .doc(widget.item['postID'])
          .collection('comments')
          .get();
      if (this.mounted) {
        setState(() {
          cmmentCount = comment.docs.length;
        });
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  void initState() {
    getCommentCount();
    super.initState();
  }

  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kPrimaryColor.withOpacity(0.1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                widget.item['profilePicture'] == ''
                    ? const CircleAvatar(
                        backgroundImage: AssetImage(Assets.imagesMan),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.item['profilePicture']),
                      ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item['displayName']),
                    Text('@' + widget.item['userName']),
                  ],
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMd().format(
                    widget.item['date'].toDate(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: widget.item['postImage'] != ''
                      ? Container(
                          margin: const EdgeInsets.all(12),
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.item['postImage']),
                            ),
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item['post'],
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    CloudMethod().likePost(widget.item['postID'],
                        userModel.userID, widget.item['like']);
                    getCommentCount();
                  },
                  icon: widget.item['like'].contains(userModel.userID)
                      ? Icon(
                          Icons.favorite,
                          color: kPrimaryColor,
                        )
                      : const Icon(Icons.favorite_border),
                ),
                Text(
                  widget.item['like'].length.toString(),
                ),
                const Gap(20),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          postID: widget.item['postID'],
                        ),
                      ),
                    );
                    getCommentCount();
                  },
                  icon: const Icon(Icons.comment),
                ),
                Text(
                  cmmentCount.toString(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
