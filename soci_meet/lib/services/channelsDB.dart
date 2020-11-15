import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/user.dart';
import 'package:socimeet/services/userDatabase.dart';

class ChannelsDatabaseServices {
  final String cid;


  ChannelsDatabaseServices({ this.cid });

  final CollectionReference channelCollection = Firestore.instance.collection(
      'Channels');

// Creating an event TODO add reading from FireBase, READ eventCount field so number of events on home will be updated
  Future createChannel(DateTime dateTime, String numberOfParticipants, User creator,String address,Channel channel, String index) async {
    final eventsCollection = channelCollection.document(channel.channelName).collection('Events');
    return await eventsCollection.document(index).setData({
      'address': address,
      'creator': creator.first_name+" "+ creator.last_name,
      'date': dateTime,
      'numberOfParticipants': numberOfParticipants,
      'counter' : 1,
      'userList': [creator.uid,],
      'eventId' : index,
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
