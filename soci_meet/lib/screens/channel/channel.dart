import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/models/party.dart';
import 'package:socimeet/models/user.dart';

import '../events/partyEvent.dart';



/*
* class Channel {
  Map<String,User> users; //unique UserId ==> will help us get boolean when added\ removed\ already in\ not signed
  List<Event> events;
  String chanelName;
}
*
* */

// class PartysChannel extends StatefulWidget {
//   Channel this_channel;
//   @override
//   _ChannelState createState() => _ChannelState();
// }
//
// class _ChannelState extends State<PartysChannel> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Partys Channel"),),
//
//
//       body:ListView.builder(itemBuilder: null) ,
//
//     );
//   }
// }
User moshe= User(emailAddress: 'moshe@peretz.com',first_name: 'moshe',last_name: 'peretz',gender: 'male',uid: '42');

class PartiesChannel extends StatefulWidget {
  @override
  _PartiesChannelState createState() => _PartiesChannelState();
}


class _PartiesChannelState extends State<PartiesChannel> {
  //uid should be unique and be received from the server

  List<Event> plist = [
    Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipantes: 1,address: "Rager 155, be'er-Sheva",creator: moshe ),
    Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipantes: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipantes: 15,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe )
  ];




  Widget cardTemplate(Event eve) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                eve.address,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '${eve.creator.first_name} ${eve.creator.last_name}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 6.0),
              Text('${eve.date.toString().substring(0,eve.date.toString().indexOf(' '))}'),
              SizedBox(height: 6.0),
              Text('${eve.date.toString().substring(eve.date.toString().indexOf(' '),(eve.date.toString().length-7) )}'),
              Text(
                '${eve.counter} / ${eve.numberOfParticipantes}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: (eve.counter == eve.numberOfParticipantes) ? Colors.red[900]
                      :  Colors.greenAccent,
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
        )
    );
  }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Parties Channel'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: plist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
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
                children: plist.map((eve) => cardTemplate(eve)).toList(),

              ),
            );
          }
      ),
    );
  }
}

