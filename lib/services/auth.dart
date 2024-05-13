import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/user_model.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  sighUp({
    required String email,
    required String passWord,
    required String dispalyName,
    required String userName,
  }) async {
    String response = 'some error';

    try {
      if (email.isNotEmpty ||
          passWord.isNotEmpty ||
          dispalyName.isNotEmpty ||
          userName.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: passWord);
        UserModel userModel = UserModel(
          userID: userCredential.user!.uid,
          userName: userName,
          bio: '',
          displayName: dispalyName,
          email: email,
          followers: [],
          following: [],
          profilePicture: '',
        );
        users.doc(userCredential.user!.uid).set(
              userModel.toJson(),
            );
        response = 'success';
      } else {
        response = 'enter all fields';
      }
    } on Exception catch (e) {
      return e.toString();
    }
    return response;
  }
}
