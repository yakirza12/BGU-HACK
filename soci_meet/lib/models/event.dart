

import 'package:socimeet/models/user.dart';

class Event {
  DateTime date;
  int numberOfParticipantes;
  User creator;
  int counter=1; //how many registered
  String address;


  Event({this.date, this.numberOfParticipantes, this.address, this.creator});
}

