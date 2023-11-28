import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_stuff/firestore_constant.dart';
import '../models/users.dart';

class UserProvider with ChangeNotifier {
  UsersModel? userModel;

  void getUserData() async {
    await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.data() != null) {
          userModel = UsersModel.fromJson(querySnapshot.data()!);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    userModel = null;
    notifyListeners();
  }
}
