import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/home_screen.dart';
Future<List<String>> getUrlsFromFirestore() async {
  List<String> urls = [];
  try {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Event').get();
    querySnapshot.docs.forEach((doc) {
      urls.add(doc['link']);
    });
  } catch (e) {
    print('Error getting URLs from Firestore: $e');
  }
  return urls;
}

// String fetching() {
//   db
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .get()
//       .then(
//         (querySnapshot) {
//       return querySnapshot.data()?['usertype'];
//       ;
//       print(category);
//     },
//     onError: (e) => print("Error completing: $e"),
//   );
// }
