


import 'package:flutter/material.dart';
import 'package:socimeet/models/event.dart';


/*
*
* class Event {
* String uId;
  DateTime date;
  int numberOfParticipantes;
  int counter;
  User creator;
  String address;

  Event({this.date, this.numberOfParticipantes, this.address, this.creator});
}
*
* */



class partyWidget extends StatefulWidget {
  Event myEvent;
  partyWidget(Event myEvent){
    this.myEvent=myEvent;
  }
  @override
  _State createState() => _State(myEvent);
}

class _State extends State<partyWidget> {
  @override
  Event myEvent;
  _State(Event myEvent){
    this.myEvent=myEvent;
  }
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Event'),
        centerTitle: true,
        backgroundColor:Colors.blue[900] ,
      ),
      body: Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 350),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
        child: Column(
        children: <Widget>[
          Row(
            children: [
              Text('Creator: ', style: TextStyle(fontSize: 20) ,),
              Text('${myEvent.creator.first_name} ${myEvent.creator.last_name}', style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Text('Date: ', style: TextStyle(fontSize: 20) ),
              Text('${myEvent.date.toString()}', style: TextStyle(fontSize: 20) ),
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
              Text('Number of participants: ', style: TextStyle(fontSize: 20) ),
              Text('${myEvent.numberOfParticipantes}', style: TextStyle(fontSize: 20) ),
            ],
          ),
          SizedBox(height: 30,),
          FloatingActionButton(
            onPressed: (){},
            child: Text('join'),
          )
        ],
      ),
      ),
      )
    );
  }
}
