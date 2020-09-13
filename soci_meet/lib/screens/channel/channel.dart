import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/event.dart';



/*
* class Channel {
  Map<String,User> users; //unique UserId ==> will help us get boolean when added\ removed\ already in\ not signed
  List<Event> events;
  String chanelName;
}
*
* */

class PartysChannel extends StatefulWidget {
  Channel this_channel;
  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<PartysChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Partys Channel"),

      body:ListView.builder(itemBuilder: null) ,

    );
  }
}

