import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userID;
  String email;
  String displayName;
  String userName;
  String bio;
  String profilePicture;
  List followers;
  List following;

  UserModel({
    required this.userID,
    required this.userName,
    required this.bio,
    required this.displayName,
    required this.email,
    required this.followers,
    required this.following,
    required this.profilePicture,
  });
//this code to get data from firebase
  factory UserModel.fromSanp(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      userID: snapshot['userID'],
      userName: snapshot['userName'],
      bio: snapshot['bio'],
      displayName: snapshot['displayName'],
      email: snapshot['email'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      profilePicture: snapshot['profilePicture'],
    );
  }
// this code to send data to firebase
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'userName': userName,
        'bio': bio,
        'displayName': displayName,
        'email': email,
        'followers': followers,
        'following': following,
        'profilePicture': profilePicture,
      };
}
