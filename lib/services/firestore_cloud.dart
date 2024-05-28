import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/services/storage.dart';
import 'package:uuid/uuid.dart';

class CloudMethod {
  CollectionReference posts = FirebaseFirestore.instance.collection('post');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  uploadPost({
    required String post,
    required String userID,
    required String dispalyName,
    required String userName,
    String?
        profilePicture, //i make it ? nullable , becuase user may not have profile picture
    required Uint8List file,
  }) async {
    String response = 'something error';
    try {
      String postID = Uuid().v1();
      String postImage =
          await StorageMethod().uploadImagetoStorage(file, 'posts', true);
      PostModel postModel = PostModel(
          userID: userID,
          userName: userName,
          post: post,
          postID: postID,
          postImage: postImage,
          date: DateTime.now(),
          like: [],
          displayName: dispalyName,
          profilePicture: profilePicture ?? '');
      posts.doc(postID).set(
            postModel.toJson(),
          );
      response = 'post done';
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  editProfile(
      {required String userID,
      required String displayName,
      required String userName,
      Uint8List? file,
      String bio = '',
      String profilePicture = ''}) async {
    String responce = 'something error';
    try {
      profilePicture =
          await StorageMethod().uploadImagetoStorage(file!, 'users', false);
    } on Exception catch (e) {
      // TODO
    }
    if (displayName != '' && userName != '') {
      users.doc(userID).update({
        'displayName': displayName,
        'userName': userName,
        'bio': bio,
        'profilePicture': profilePicture
      });
      responce = 'success';
    }
    return responce;
  }
}
