

import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/user.dart';

class Channel {

  Map<String,User> users; //unique UserId ==> will help us get boolean when added\ removed\ already in\ not signed
  List<Event> events;
  String chanelName;

  Channel({this.chanelName,this.users,this.events});
}