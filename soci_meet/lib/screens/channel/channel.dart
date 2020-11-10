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

  List<Event> _events = [
    //   Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipants: 1,address: "Rager 155, be'er-Sheva",creator: moshe ),
    //   Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipants: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
    //   Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 15,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe )
  ];


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
                                  partyWidget(eve)
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
                ' ', //Todo UID תוסיף לי כאן תשם אחשלי היקר
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
            _buildEventsList(context, snapshot.data.documents);
            return SafeArea(
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text('Parties Channel'),
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
                      itemCount: _events.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 4.0),
                          child: Column(
                            // children:
                            // [
                            //   Card(
                            //     child: ListTile(
                            //       onTap: () {},
                            //       title: Text(plist[index].location),
                            //       leading: CircleAvatar(
                            //         backgroundImage: AssetImage('assets/${plist[index].flag}'),
                            //       ),
                            //     ),
                            //   ),
                            // ],
                            children: _events.map((eve) => cardTemplate(eve))
                                .toList(),

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







