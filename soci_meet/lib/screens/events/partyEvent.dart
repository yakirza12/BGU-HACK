
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

      color: Colors.lightBlue[100],
      padding: EdgeInsets.fromLTRB(20, 30,0,0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Text('Creator', style: TextStyle(fontSize: 20) ,),
              SizedBox(height: 30,),
              Text('${myEvent.creator}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 30,),
            ],
          ),
          Row(
            children: [
              Text('Date', style: TextStyle(fontSize: 20) ),
              SizedBox(height: 30,),
              Text('${myEvent.date.toString()}', style: TextStyle(fontSize: 20) ),
              SizedBox(height: 30,),
            ],
          ),
          Row(
            children: [
              Text('Adress', style: TextStyle(fontSize: 20) ),
              SizedBox(height: 30,),
              Text('${myEvent.address}', style: TextStyle(fontSize: 20) ),
              SizedBox(height: 30,),
            ],
          ),
          Row(
            children: [
              Text('Number of participants', style: TextStyle(fontSize: 20) ),
              SizedBox(height: 30,),
              Text('${myEvent.numberOfParticipantes}', style: TextStyle(fontSize: 20) ),
              SizedBox(height: 30,),
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
