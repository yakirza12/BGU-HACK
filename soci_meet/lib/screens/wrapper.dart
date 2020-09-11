import 'package:socimeet/models/user.dart';
import 'package:socimeet/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'autenticates/autenticate.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // listen to the provider, if it will be null we will navigate to the log in page. else we can access the user data from the provider.
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }

  }
}