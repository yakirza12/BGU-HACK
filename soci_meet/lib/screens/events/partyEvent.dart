


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/user.dart';
import 'package:socimeet/screens/channel/addEventForm.dart';
import 'package:socimeet/screens/channel/addEventForm.dart';
import 'package:socimeet/services/channelsDB.dart';
import 'package:socimeet/services/userDatabase.dart';

showAlertDialog(BuildContext context,String msg) {

  // set up the buttons
  Widget okButton = FlatButton(
    child: Text("Ok"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(msg),
    actions: [
      okButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


class partyWidget extends StatefulWidget {
  Event myEvent;
  User login_user;
  partyWidget(Event myEvent,User login_user){
    this.myEvent=myEvent;
    this.login_user = login_user;
  }
  @override
  _State createState() => _State(myEvent);
}

class _State extends State<partyWidget> {
  @override
  Event myEvent;
  bool isJoined = false;
  _State(Event myEvent){
    this.myEvent=myEvent;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        centerTitle: true,
        backgroundColor:Colors.blue[900] ,
        actions: [creatorDelete(widget.login_user, myEvent)],
      ),
      body:Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 280),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text('Creator: ', style: TextStyle(fontSize: 20) ,),
                  Text(myEvent.creator, style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text('Date: ', style: TextStyle(fontSize: 20) ),
                  Text('${myEvent.date.toString().substring(0,myEvent.date.toString().indexOf(' '))}', style: TextStyle(fontSize: 20) ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text('Time: ', style: TextStyle(fontSize: 20) ),
                  Text('${myEvent.date.toString().substring(myEvent.date.toString().indexOf(' '),myEvent.date.toString().length-7)}', style: TextStyle(fontSize: 20) ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text('Address: ', style: TextStyle(fontSize: 20) ),
                  Text('${myEvent.address}', style: TextStyle(fontSize: 20) ),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text('Number of participants: ${myEvent.counter}/', style: TextStyle(fontSize: 20) ),
                  Text('${myEvent.numberOfParticipants}', style: TextStyle(fontSize: 20) ),
                ],
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          for(int i = 0;i<myEvent.userList.length;i++){
            if(widget.login_user.uid == myEvent.userList[i] ){
              isJoined = true;
            }
          }
          if(!isJoined){
            if(myEvent.counter < int.parse(myEvent.numberOfParticipants)){
              setState(() {
                myEvent.counter++;
                EventForm(null,null,null).updateUserEventsIdMap(widget.login_user, myEvent.channelName, myEvent.eventId); //add to event id map
                ChannelsDatabaseServices().updateEvent( myEvent.channelName, myEvent.eventId, myEvent.counter, widget.login_user.uid,myEvent.userList);//update event in firebase + update eventUserList
                UserDatabaseService().updateUserEvents(widget.login_user); //update in database the event id map
              });
              isJoined=true;
              Navigator.pop(context);
            }
            else{
              showAlertDialog(context,"This event is already full!");
            }
          }
          else{
            showAlertDialog(context,widget.login_user.first_name+" you are already a part of this event");
          }
        },
        child: Text('join'),
      ),
    );
  }
  void deleteEventFromMap(User user, String channelName, String eventId){// delete event id from map
    user.userEventsIdMap.forEach((key, value) {
      if(value.contains(eventId)){
        value.remove(eventId);
       return;
      }
    });
  }
  Widget creatorDelete(User user,Event event){
    if(user.uid == event.creator_id ) {
     return FlatButton.icon(
          icon: Icon(Icons.delete),
          onPressed: () async {
            event.userList.map((uid){ //for each user in this event, delete the event id from its map in the database
              Future<User> user =Firestore.instance.collection('users').document(uid).get().then((doc) =>User.fromSnapshot(doc, uid));
              user.then((userFuture)=>deleteEventFromMap(userFuture, event.channelName, event.eventId));
              user.then((userFuture)=> UserDatabaseService().updateUserEvents(userFuture));
            });
            deleteEventFromMap(user, event.channelName, event.eventId);
            UserDatabaseService().updateUserEvents(user);
            Firestore.instance.collection('Channels').document(event.channelName)
                .collection('Events').document(event.eventId)
                .delete();
            Navigator.pop(context);
          },
         label: Text(""));
    }
      return FlatButton.icon(icon: Icon(Icons.delete),label: Text(""),);
  }
}
