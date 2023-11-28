import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  final String name;
  final String dsc;
  final String rStDate;
  final String rEdDate;
  final String nDays;
  final String eDate;
  final String organisers;
  final String location;
  late String img;
  final String link;
  final String time;

  EventModel({
    required this.id,
    required this.name,
    required this.dsc,
    required this.rStDate,
    required this.rEdDate,
    required this.nDays,
    required this.eDate,
    required this.organisers,
    required this.location,
    required this.img,
    required this.link,
    required this.time,
  });

  toJson() {
    return {
      'name': name,
      'dsc': dsc,
      'rStDate': rStDate,
      'rEdDate': rEdDate,
      'nDays': nDays,
      'eDate': eDate,
      'organisers': organisers,
      'location': location,
      'img': img,
      'link':link,
      'time':time,
    };
  }

  factory EventModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EventModel(
      id: document.id,
      name: data['name'],
      img: data['img'],
      dsc: data['dsc'],
      rStDate: data['rStDate'],
      rEdDate: data['rEdDate'],
      nDays: data['nDays'],
      eDate: data['eDate'],
      organisers: data['organisers'],
      location: data['location'],
      link: data['link'],
      time: data['time']
    );
  }
}
