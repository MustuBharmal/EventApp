import 'package:flutter/material.dart';

import '../firebase_stuff/firestore_constant.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  final List<EventModel> allEvent = [];

  // void deleteEvent(String id) {
  //   allEvent.removeWhere((element) => element.id == id);
  // }

  Future<void> fetchEventData() async {
    allEvent.clear();
    final docRef = db.collection('Event');
    try{
      await docRef.orderBy('rEdDate').get().then(
            (ref) {
          for (var element in ref.docs) {
            allEvent.add(EventModel.fromSnapshot(element));
          }
        },
        onError: (e) => print('Error getting document: $e'),
      );
      notifyListeners();
    }catch(e){
      print('Error getting documents: $e');
    }

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

  List<EventModel> get event {
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

  Future<void> updateEvent(String? id, EventModel editedEvent) async {
    var col = db.collection('events');
    col.doc('id').update(
          editedEvent.toJson(),
        );
    notifyListeners();
  }

  void removeItem(String eventId) async {
    await db.collection("Event").doc(eventId).delete();
  }
}
