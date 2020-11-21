import 'package:flutter/material.dart';
import 'package:socimeet/services/auth.dart';

///Register screen
class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String first_name = '';
  String last_name = '';
  String gender = '';
  String error = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue, //for the appbar
          elevation: 0.0, // elevation from the screen
          title: Text('Sign up'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
              onPressed: () {
                widget.toggleView(); // this is how we call to the function
              },
            )
          ],
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            // wil help as to scrolling down with no issue
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 22.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Form(
                  key: _formKey, // keep truck to our form, for validate.
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),

                      /// form field for email
                      // TODO add email validation field
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter an email" : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              borderSide: new BorderSide(),
                            ),
                            labelText: "Enter Email"),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      new Padding(padding: EdgeInsets.all(8.0)),

                      /// form field for password
                      // TODO add a password validation form field
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? "Enter password longer then 6"
                            : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              borderSide: new BorderSide(),
                            ),
                            labelText: "Password"),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        obscureText: true,
                        //for password
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      new Padding(padding: EdgeInsets.all(8.0)),

                      /// form field for first name
                      TextFormField(
                        validator: (val) =>
                            val.length < 2 ? "Enter valied name" : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              borderSide: new BorderSide(),
                            ),
                            labelText: "First Name"),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        onChanged: (val) {
                          setState(() {
                            first_name = val;
                          });
                        },
                      ),
                      new Padding(padding: EdgeInsets.all(8.0)),

                      /// form field for last name
                      TextFormField(
                        validator: (val) =>
                            val.length < 2 ? "Enter valied name" : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              borderSide: new BorderSide(),
                            ),
                            labelText: "Last Name"),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        onChanged: (val) {
                          setState(() {
                            last_name = val;
                          });
                        },
                      ),

                      /// Field for gender
                      // TODO add Gender choice
                      TextFormField(
                        validator: (val) =>
                            val.length < 2 ? "Enter valied name" : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              borderSide: new BorderSide(),
                            ),
                            labelText: "Gender"),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        onChanged: (val) {
                          setState(() {
                            gender = val;
                          });
                        },
                      ),

                      /// Press and you will be registered!
                      ///
                      /// here we will validate the form, and contact firebase to add a new user
                      RaisedButton(
                        color: Colors.pink[52],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState
                              .validate()) //will check if our from is legit
                          {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email,
                                    password,
                                    first_name,
                                    last_name,
                                    gender,
                                    Map<String, String>());
                            if (result == null) {
                              setState(() => error =
                                  'Could not sign in with those credentials'); //TODO check
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
          );
        }));
  }
}
