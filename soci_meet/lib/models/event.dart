

import 'package:socimeet/models/user.dart';

class Event {
  DateTime date;
  int numberOfParticipantes;
  User creator;
  String address;


  Event({this.date, this.numberOfParticipantes, this.address, this.creator});
}

