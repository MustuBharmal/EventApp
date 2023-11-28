import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../firebase_stuff/firestore_constant.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  final List<EventModel> allEvent = [];
  final List<EventModel> currEvent = [];

  Future<void> fetchEventData() async {
    allEvent.clear();
    final docRef = db.collection('Event');
    await docRef.orderBy('rEdDate').get().then(
      (ref) {
        for (var element in ref.docs) {
          allEvent.add(EventModel.fromSnapshot(element));
        }
      },
      onError: (e) => print('Error getting document: $e'),
    );
    notifyListeners();
  }

  Future<void> addEventData(EventModel data) async {
    try {
      final doc = await db.collection(eventDataRef).add(data.toJson());
      if (doc.id != '') {
        data.id = doc.id;
      }
      allEvent.add(data);
      notifyListeners();
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  List<EventModel> get event2 {
    return [...allEvent];
  }

  EventModel findById(String id) {
    return allEvent.firstWhere((event) => event.id == id);
  }

  List<EventModel> getAllEvent() {
    List<EventModel> userList = [];
    userList.addAll(allEvent);
    return userList;
  }

  List<EventModel> getPastEvent() {
    List<EventModel> userList = [];
    userList.addAll(allEvent);
    return userList;
  }
}
