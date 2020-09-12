import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socimeet/models/user.dart';
import 'package:socimeet/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'autenticates/autenticate.dart';

DocumentSnapshot snapshot;

class Wrapper extends StatelessWidget {
  @override

  Future getSnap(String uid) async { //use a Async-await function to get the data
    final data = await Firestore.instance.collection("users").document(uid).get(); //get the data
    snapshot = data;
  }


  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // listen to the provider, if it will be null we will navigate to the log in page. else we can access the user data from the provider.
    if(user == null){
      return Authenticate();
    }else {

      getSnap(user.uid);
     // User(uid: user.uid,emailAddress: user.email, first_name: first_name,last_name: last_name,gender:gender)

      final login_user = User(uid: user.uid,emailAddress :snapshot.data['emailAddress'].toString(),first_name : snapshot.data['first_name'].toString(),
          last_name:   snapshot.data['last_name'].toString(),gender: snapshot.data['gender'].toString());


      return Home(login_user); // get the full user data from the firstore DB.
    }

  }
}