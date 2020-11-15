import 'package:cloud_firestore/cloud_firestore.dart';

class User{ // the user object, need to be expandent in the future

  final String uid;
  final String emailAddress;
  final String first_name;
  final String last_name;
  final String gender;
  Map <String,dynamic> userEventsIdList;//TODO this should be Map<String,String> but it is not working otherwise
  final DocumentReference reference;


  User({this.uid,this.emailAddress,this.first_name,this.last_name,this.gender,this.reference}); //the constructor for user

  User.fromMap(Map<String, dynamic> map,String _uid, {this.reference}):
        assert(map['emailAddress'] != null),
        assert(map['first_name'] != null),
        assert(map['last_name'] != null),
        assert(map['gender'] != null),
        assert(map['userEventsIdList'] != null),
        uid = _uid,
        emailAddress = map['emailAddress'],
        first_name = map['first_name'],
        last_name = map['last_name'],
        gender = map['gender'],
        userEventsIdList = map['userEventsIdList'];


  User.fromSnapshot(DocumentSnapshot snapshot,String user_uid)
      : this.fromMap(snapshot.data,user_uid,reference: snapshot.reference);



}