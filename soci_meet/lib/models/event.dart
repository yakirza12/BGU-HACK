

import 'package:socimeet/models/user.dart';

class Event {
  DateTime date;
  int numberOfParticipants;
  User creator;
  int counter=1; //how many registered
  String address;
  String eventId;


  Event({this.date, this.numberOfParticipants, this.address, this.creator,this.eventId});

 // static User moshe= User(emailAddress: 'moshe@peretz.com',first_name: 'moshe',last_name: 'peretz',gender: 'male',uid: '42');

  static List<Event> plist = [
  //   Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipantes: 1,address: "Rager 155, be'er-Sheva",creator: moshe ),
  //   Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipantes: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
  //   Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipantes: 15,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe )
  ];

}

