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

//comment method
  commentToPost({
    required String postID,
    required String userID,
    required String commentText,
    required String profilePicture,
    required String displayName,
    required String userName,
  }) async {
    String response = 'somthing error';
    try {
      if (commentText.isNotEmpty) {
        String commentID = Uuid().v1();
        posts.doc(postID).collection('comments').doc(commentID).set({
          'userID': userID,
          'postID': postID,
          'commentID': commentID,
          'commentText': commentText,
          'profilePicture': profilePicture,
          'displayName': displayName,
          'userName': userName,
          'date': DateTime.now(),
        });
        response = 'success';
      }
    } on Exception catch (e) {
      // TODO
    }
    return response;
  }

  likePost(String postID, String userID, List like) async {
    String response = 'somthing error';
    try {
      //if the user liked this post before and press on like , unlike the post
      if (like.contains(userID)) {
        posts.doc(postID).update(
          {
            'like': FieldValue.arrayRemove(
              [userID],
            ),
          },
        );
        //if the user did not like this post before and press on like , like the post
      } else {
        (
          posts.doc(postID).update(
            {
              'like': FieldValue.arrayUnion(
                [userID],
              ),
            },
          ),
        );
        response = 'success';
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  editProfile(
      {required String userID,
      required String displayName,
      required String userName,
      Uint8List? file,
      String bio = '',
      String profilePicture = ''}) async {
    String response = 'something error';
    try {
      profilePicture = file != null
          ? await StorageMethod().uploadImagetoStorage(file!, 'users', false)
          : '';
      if (displayName != '' && userName != '') {
        users.doc(userID).update({
          'displayName': displayName,
          'userName': userName,
          'bio': bio,
          'profilePicture': profilePicture
        });
        response = 'success';
      }
      return response;
    } on Exception catch (e) {
      //TODO
    }
    return response;
  }

  /* followUser(String userID, String followUserID) async {
    DocumentSnapshot documentSnapshot = await users.doc(userID).get();
    //this method will check if the another user is in the current user`s following list, if true, remove the another user from following list
    List following = (documentSnapshot.data()! as dynamic)['following'];
    try {
      if (following.contains(followUserID)) {
        await users.doc(userID).update({
          'following': FieldValue.arrayRemove([followUserID])
        });
        await users.doc(followUserID).update({
          'followers': FieldValue.arrayRemove([userID])
        });
      } else {
        //if another user is not in current user`s follwing list , add it in the list
        await users.doc(userID).update({
          'following': FieldValue.arrayUnion([followUserID])
        });
        //if current user is not in another user`s followers list , add it in the list
        await users.doc(followUserID).update({
          'followers': FieldValue.arrayUnion([userID])
        });
      }
    } on Exception catch (e) {
      // TODO
    }
  }*/
  //same code as above but better
  Future<void> followUser(String userID, String followUserID) async {
    final userDoc = users.doc(userID);
    final followUserDoc = users.doc(followUserID);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot userSnapshot = await transaction.get(userDoc);
        DocumentSnapshot followUserSnapshot =
            await transaction.get(followUserDoc);

        List following = userSnapshot['following'] ?? [];
        List followers = followUserSnapshot['followers'] ?? [];

        if (following.contains(followUserID)) {
          // Remove followUserID from user's following list
          transaction.update(userDoc, {
            'following': FieldValue.arrayRemove([followUserID])
          });

          // Remove userID from followUser's followers list
          transaction.update(followUserDoc, {
            'followers': FieldValue.arrayRemove([userID])
          });
        } else {
          // Add followUserID to user's following list
          transaction.update(userDoc, {
            'following': FieldValue.arrayUnion([followUserID])
          });

          // Add userID to followUser's followers list
          transaction.update(followUserDoc, {
            'followers': FieldValue.arrayUnion([userID])
          });
        }
      });
    } catch (e) {
      // Handle exceptions, log error or provide user feedback
      print("Error following/unfollowing user: $e");
    }
  }

  deletePost(String postID) async {
    String response = 'error';
    try {
      await posts.doc(postID).delete();
      response = 'success';
    } catch (e) {}
    return response;
  }
}
