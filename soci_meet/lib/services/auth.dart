import 'dart:collection';

import 'package:socimeet/models/user.dart';
import 'package:socimeet/services/database.dart';


import 'package:firebase_auth/firebase_auth.dart';




class AuthService{



  final FirebaseAuth _auth = FirebaseAuth.instance; //singeltone of the firebase aut h object. to get all data from firebase
//create user object based firebase object
  User _userFromFirebaseUser(FirebaseUser user,String first_name , String last_name, String gender){ // create our user from the the firebase instance user, we want to get te functionality of the user.
    return user!=null ? User(uid: user.uid,emailAddress: user.email, first_name: first_name,last_name: last_name,gender:gender) : null;
  }

//auth change user stream
  Stream<User> get user { // going to return as User object was stream, and who logs in. with that info we can know how to navigate him
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user,user.email,"",""));
  }


//register with email and password
  Future registerWithEmailAndPassword(String email,String Password, String first_name , String last_name, String gender)  async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: Password);
      FirebaseUser user = result.user;
      // create Document for user database.
      await DatabaseService(uid: user.uid).updateUserData(email,first_name,last_name,gender); // sign the user document to get his data.
      User appUser = _userFromFirebaseUser(user,first_name,last_name,gender);
      //  _userList.putIfAbsent(user.uid,() => appUser);
      return appUser;
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }
//sign in with email and password
  Future sighinWithEmailAndPassword(String email,String password)  async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(result);
      //return _userFromFirebaseUser(user, "_userList[user.uid].Groom_name","_userList[user.uid].Bride_name"); //TODO chage it because does not recognize all othe things.
      User appUser = _userFromFirebaseUser(user,"Groom_name,Bride_name","","");
      //_userList.putIfAbsent(user.uid,() => appUser);
      return appUser;
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }





//sign in anon not will use it in my app
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user ," " ," ",""); // add empty string fot the othr func.
    } catch(e){
      print(e.toString());
      return null;
    }
  }




  //register with facebook account

  //register with google account

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }

  }

}