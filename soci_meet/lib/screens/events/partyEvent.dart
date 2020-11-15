


import 'package:flutter/material.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/user.dart';
import 'package:socimeet/services/channelsDB.dart';

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
                ChannelsDatabaseServices().updateEvent(myEvent.date, myEvent.numberOfParticipants, widget.login_user, myEvent.address, myEvent.channelName, myEvent.eventId, myEvent.counter, widget.login_user.uid,myEvent.userList);
              });
              isJoined=true;
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
}
