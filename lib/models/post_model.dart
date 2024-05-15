import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String userID;
  String displayName;
  String userName;
  String post;
  String postID;
  String postImage;
  DateTime date;
  dynamic like;
  String profilePicture;

  PostModel({
    required this.userID,
    required this.userName,
    required this.post,
    required this.postID,
    required this.postImage,
    required this.date,
    required this.like,
    required this.displayName,
    required this.profilePicture,
  });
//this code to get data from firebase
  factory PostModel.fromSanp(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      userID: snapshot['userID'],
      userName: snapshot['userName'],
      post: snapshot['post'],
      displayName: snapshot['displayName'],
      postID: snapshot['postID'],
      postImage: snapshot['postImage'],
      date: snapshot['date'],
      profilePicture: snapshot['profilePicture'],
      like: snapshot['like'],
    );
  }
// this code to send data to firebase
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'userName': userName,
        'post': post,
        'postID': postID,
        'pistImage': postImage,
        'displayName': displayName,
        'profilePicture': profilePicture,
        'date':date,
        'like':like,
      };
}
