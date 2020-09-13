
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
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('Creator'),
              Text('{$myEvent.creator}')
            ],
          ),
          Row(
            children: [
              Text('Date'),
              Text('{$myEvent.myEvent.date.toString()}')
            ],
          ),
          Row(
            children: [
              Text('Adress'),
              Text('{$myEvent.address}')
            ],
          ),
          Row(
            children: [
              Text('Number of participants'),
              Text('{$myEvent.numberOfParticipantes}')
            ],
          ),
          FloatingActionButton(
            onPressed: (){},
            child: Text('join'),
          )
        ],
      ),
    );
  }
}
