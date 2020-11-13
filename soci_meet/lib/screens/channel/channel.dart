import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/party.dart';
import 'package:socimeet/models/user.dart';
import 'addEventForm.dart';

import '../events/partyEvent.dart';



// User moshe= User(emailAddress: 'moshe@peretz.com',first_name: 'moshe',last_name: 'peretz',gender: 'male',uid: '42');

class ChannelWidget extends StatefulWidget {
  User login_user;
  final ChannelName;

  ChannelWidget(this.ChannelName,this.login_user);

  // ignore: non_constant_identifier_names
  // final User login_user;

  // PartiesChannel(this.login_user);

  @override
  _ChannelState createState() => _ChannelState();
}


class _ChannelState extends State<ChannelWidget> {
  //uid should be unique and be received from the server

  List<Event> _events = [];


  Widget cardTemplate(Event eve) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(

                children: [
                  Text(
                    eve.address,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  partyWidget(eve,widget.login_user)
                          )

                      );
                    },
                    icon: Icon(Icons.info),
                    label: Text(''),

                  )

                ],
              ),

              // SizedBox(height: 2.0),
              Text(
                widget.login_user.first_name+" "+ widget.login_user.last_name,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  Text('${eve.date.toString().substring(
                      0, eve.date.toString().indexOf(' '))}'),
                  SizedBox(width: 50.0),
                  Text('${eve.date.toString().substring(
                      eve.date.toString().indexOf(' ') + 1, (eve.date
                      .toString()
                      .length - 7))}'),
                ],
              ),

              Text(
                '${eve.counter} / ${eve.numberOfParticipants}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: (eve.counter == eve.numberOfParticipants) ? Colors
                      .red[900]
                      : Colors.greenAccent,
                ),
              ),


            ],
          ),
        )
    );
  }


  void _buildEventsList(BuildContext context, List<DocumentSnapshot> snapshot) {
    _events = snapshot.map((data) {
      final event = Event.fromSnapshot(data);
      return event;
    }).toList();
    for (int i = 0; i < _events.length; i++) { /* Removes events one day after they are over from the DB */
      if (_events[i].date.day.compareTo(DateTime.now().day+1) < 0 && _events[i].date.month.compareTo(DateTime.now().month)==0 && _events[i].date.year.compareTo(DateTime.now().year)==0 ) {
        Firestore.instance.collection('Channels').document(widget.ChannelName)
            .collection('Events').document(_events[i].eventId)
            .delete();
        _events.remove(i);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Channels')
            .document(widget.ChannelName)
            .collection('Events')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          else {
            _buildEventsList(context, snapshot.data.documents);//TODO HERE THE LIST IS CREATED
            return SafeArea(
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text(widget.ChannelName),
                  centerTitle: true,
                  elevation: 0,
                ),

                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    var alertDialog = AlertDialog(
                      title: Text("Add Event"),
                      content: EventForm(
                          widget.ChannelName, widget.login_user, _events),
                    );
                    showDialog(context: context, builder: (_) => alertDialog);
//         Navigator.push(context,
//              MaterialPageRoute(builder: (context) => StreamProvider<User>.value(
//                  value: AuthService().user,
//                  child: GuestForm()
//              )
//              )
//          );
                  },
                  child: Icon(Icons.add),
                ),
                body: Container(

                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 4.0),
                          child: Column(
                            children:_events.map((eve) => cardTemplate(eve)).toList(),
                          ),
                        );
                      }
                  ),
                ),
              ),
            );
          }
        });
  }
}







