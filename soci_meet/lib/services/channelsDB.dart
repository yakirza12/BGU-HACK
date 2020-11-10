import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/user.dart';

class ChannelsDatabaseServices {
  final String eid;


  ChannelsDatabaseServices({ this.eid });

  final CollectionReference channelCollection = Firestore.instance.collection(
      'Channels');

// Creating an event
  Future createEvent(DateTime dateTime, String numberOfParticipants, User creator,
      String address,String channel, String index) async {
   //final index = UniqueKey().toString();
   print("THIS IS THE CREATOR: "+ creator.first_name);
    final eventsCollection = channelCollection.document(channel).collection('Events');
    return await eventsCollection.document(index).setData({
      'address': address,
      'creator': creator.first_name,
      'date': dateTime,
      'numberOfParticipants': numberOfParticipants,
      'counter' : 1,
      'userList': [creator.uid,],
    });
  }
}


























/*
//Collection Reference
  final CollectionReference eventsCollection = Firestore.instance.collection(
      'Events');

// Creating an event
  Future createEvent(DateTime dateTime, int numberOfParticipants, User creator,
       String address,String index) async {
    print("THIS IS THE CREATOR: "+ creator.first_name);
    return await eventsCollection.document(index).setData({
      'address': address,
      'creator': creator.first_name,
      'date': dateTime,
      'n_o_f': numberOfParticipants,
      'userList': [creator.uid,],
    });
  }*/
