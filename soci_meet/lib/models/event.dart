

import 'package:socimeet/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  DateTime date = DateTime.now();
  String numberOfParticipants;
  String creator;
  int counter = 1; //how many registered
  String address;
  String eventId;
  final DocumentReference reference;


  Event(
      {this.date, this.numberOfParticipants, this.address, this.creator, this.eventId, this.reference});

  // static User moshe= User(emailAddress: 'moshe@peretz.com',first_name: 'moshe',last_name: 'peretz',gender: 'male',uid: '42');

  static List<Event> plist = [
    //   Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipantes: 1,address: "Rager 155, be'er-Sheva",creator: moshe ),
    //   Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipantes: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
    //   Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipantes: 15,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe )
  ];

  Event.fromMap(Map<String, dynamic> map, {this.reference})
      :
       //assert(map['date'] != null),
        assert(map['numberOfParticipants'] != null),
        assert(map['creator'] != null),
        assert(map['counter'] != null),
        assert(map['address'] != null),
        //assert(map['eventId'] != null),
       // date = map['date'],
        numberOfParticipants = map['numberOfParticipants'],
        creator = map['creator'],
        counter = map['counter'],
        address = map['address'];
        //eventId = map['eventId'];

  Event.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'numberOfParticipants': numberOfParticipants,
      'creator': creator,
      'counter': counter,
      'address': address,
      'eventId': eventId,
      'date': date,
    };
  }
}

