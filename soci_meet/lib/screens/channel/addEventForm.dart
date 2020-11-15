import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/user.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socimeet/services/auth.dart';
import 'channel.dart';
import 'package:socimeet/models/event.dart';
import 'package:socimeet/services/channelsDB.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class EventForm extends StatefulWidget {
  final User user;
  List<Event> _events;
  bool isValid = false;
 final Channel channel;
  EventForm(this.channel,this.user,this._events);

  // User({this.uid,this.emailAddress,this.first_name,this.last_name,this.gender}); //the constructor for user

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  DateTime date;
  String numberOfParticipantes;
  User creator;
  int counter=1; //how many registered
  String address;

  @override
  Widget build(BuildContext context) {
    //   final user = Provider.of<User>(context);
    return SingleChildScrollView(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            key: _formKey, // keep truck to our form, for validate.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? "enter Address" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Address"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    _formKey.currentState.save();
                    setState(() {
                      address = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                DateTimeField(
                  format: DateFormat("yyyy-MM-dd 'At' HH:mm"),
                  onShowPicker: (context, currentValue) async {
                     date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Date"),
                    onChanged:(dt) {
                      _formKey.currentState.save();
                      setState(() {
                        date = dt;
                      });
                    }),

                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) => numberValidator(val),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Number of participants"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    final form = _formKey.currentState;
                    if(form.validate())
                      widget.isValid = true;// TODO this only works correctly when user fill fields from top to bottom, need to find a better way to do it
                    setState(() {
                      numberOfParticipantes = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),

                RaisedButton(
                  color:widget.isValid ? Colors.blue: Colors.pink[52],
                  child: Text(
                    'Add event',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final form = _formKey.currentState;
                    form.save();
                    if (form.validate()) //will check if our from is legit
                        {
                          widget.isValid = true;//TODO how to set the state of the color without using the onPress method? when to form is Valid I want the color to chane
                          String event_key = UniqueKey().toString();
                          Navigator.pop(context);
                          dynamic result = _auth.createEvent(date, numberOfParticipantes , widget.user , address,widget.channel,event_key);//TODO Use Event Ref From FireBase Event so you can add him to user EventsList
                          widget.channel.eventCount++;
                      }
                    }
                ),
                SizedBox(height: 12.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String numberValidator(String value) {
  if (value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if (n == null) {
    return '"$value" is not a valid number';
  }
  return null;
}
