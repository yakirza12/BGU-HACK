


import 'package:flutter/material.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/user.dart';

showAlertDialog(BuildContext context) {

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
    content: Text("This event is already full!"),
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
                  Text(widget.login_user.first_name+" "+ widget.login_user.last_name, style: TextStyle(fontSize: 20)),
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
          if(!isJoined){
            if(myEvent.counter < (myEvent.numberOfParticipants as int)){
              setState(() {
                myEvent.counter++;
              });
              isJoined=true;
            }
            else{
              showAlertDialog(context);
            }
          }
        },
        child: Text('join'),
      ),
    );
  }
}
