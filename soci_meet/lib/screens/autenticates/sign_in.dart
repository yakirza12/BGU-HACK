
import 'package:socimeet/services/auth.dart';
import 'package:socimeet/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SignIn2 extends StatefulWidget {

  final Function toggleView;
  SignIn2({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn2> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // for validation

  //text field states

  String email = '';
  String password = '';
  String error = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              color: Color(0xFFFFCCBF),
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.83), BlendMode.dstATop),
                image: AssetImage("assets/ness-meet.jpg"),
                fit: BoxFit.cover,
              ),

            ),
            child: Center(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 16,
                    right:16,
                    top:100,
                    bottom:-280,

                    child: new Center(

                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.90), BlendMode.dstATop),
                          child: Container(


                            padding: EdgeInsets.only(right: 15),
                            width: 400.0,
                            height: 285.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0.0),
                                color: Color(0xffffffff),
                                backgroundBlendMode: BlendMode.dstATop
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:40.0,right:15.0,top: 20 ) ,
                              child: Column(

                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      Text(
                                        "SIGN IN",
                                        style:Theme.of(context).textTheme.display1,

                                        /* TextStyle(
                                    color: Color(0xFFEF9A9A),
                                    fontSize: 40,

                                    fontWeight: FontWeight.w500
                                  ),*/
                                      ),
                                      FlatButton(
                                        child: Text ('SIGN UP',style: Theme.of(context).textTheme.button),
                                        onPressed: (){
                                          widget.toggleView();
                                        },
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: Icon(
                                            Icons.alternate_email,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            validator: (val) => val.isEmpty ? "Enter an email" : null,
                                            keyboardType: TextInputType.emailAddress,
                                            // style: TextStyle(color: Color(0xFFB0CBC4)),
                                            decoration: InputDecoration(
                                              hintText: "Enter Email Address",
                                              //hintStyle: TextStyle(color: Colors.black)
                                            ),
                                            onChanged: (val){
                                              setState(() {
                                                email = val;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16,top: 5),
                                        child: Icon(
                                          Icons.lock,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            obscureText: true,
                                            validator: (val) => val.length < 6 ? "Enter valied password" : null,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(top: 14.0),

                                              hintText: 'Enter Password',
                                              // hintStyle: kHintTextStyle,
                                            ),

                                            onChanged: (val){
                                              setState(() {
                                                password = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Spacer(),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(

                                      children: <Widget>[

                                        Container(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          height: 50.0,
                                          margin: const EdgeInsets.only(left: 80.0, right: 15.0, top: 0.0),
                                          alignment: Alignment.center,

                                          child: new FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(30.0)),
                                              color: Colors.deepOrangeAccent[100],
                                              onPressed: () async {
                                                if(_formKey.currentState.validate())//will check if our from is legit
                                                    {
                                                  print(email);
                                                  print(password);
                                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                                                  if(result == null) {
                                                    setState(() =>
                                                    error = 'please suppp error on register'); //TODO check
                                                  }
                                                }

                                              },
                                              child: new Container(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 00,
                                                  horizontal: 3.0,

                                                ),
                                                margin: EdgeInsets.all(7),
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Expanded(
                                                      child: Text(
                                                        "LOGIN",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )

                                          ),

                                          /*child:IconButton(icon:  Icon(Icons.arrow_forward,
                                      color: Color(0xFFEFEBE9)
                                  ),   onPressed: () async {
                                    if (_formKey.currentState
                                        .validate()) //will check if our from is legit
                                        {
                                      dynamic result = await _auth
                                          .sighinWithEmailAndPassword(email, password);

                                      if (result == null) {
                                        setState(() =>
                                        error =
                                        'please suppp error on register'); //TODO check
                                      }
                                    }
                                  })*/
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ),
                        )
                    ),
                  )],
              ),
            )
        ),
      ),
    );

  }
}

/*
    return Scaffold(


      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,//for the appbar
        elevation: 0.0, // elevation from the screen
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text ('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],

      ),


      body:Column(
        children: <Widget>[
          Expanded(flex: 3,
            child: Container(

              decoration: BoxDecoration(
                
                image: DecorationImage(

                  image: AssetImage("assets/HappyPhoto.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),

          ),
          Expanded( 
            flex: 3,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text(
                        "SIGN IN",
                        style:Theme.of(context).textTheme.display1,

                        TextStyle(
                          color: Color(0xFFEF9A9A),
                          fontSize: 40,

                          fontWeight: FontWeight.w500
                        ),
                      ),
                      FlatButton(
                        child: Text ('SIGN UP',style: Theme.of(context).textTheme.button),
                        onPressed: (){
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.alternate_email,
                            color: kPrimaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Color(0xFFB0CBC4)),
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle: TextStyle(color: Colors.black12)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16,top: 5),
                        child: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(

                         validator: (val) => val.length < 6 ? "Enter valied password" : null,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),

                            hintText: 'Enter your Password',
                           // hintStyle: kHintTextStyle,
                          ),





                           InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black)


                          )
                          onChanged: (val){
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Password',
                    //style: kLabelStyle,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    //decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your Password',
                        //hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          ),
                          child:IconButton(icon:  Icon(Icons.arrow_forward,
                                color: Color(0xFFEFEBE9)
                                ),   onPressed: () async {
                            if (_formKey.currentState
                                .validate()) //will check if our from is legit
                                {
                              dynamic result = await _auth
                                  .sighinWithEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() =>
                                error =
                                'please suppp error on register'); //TODO check
                              }
                            }
                          })
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ),
        ],
      )








      Container(

        padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 50.0),

        child: Form(
          key: _formKey, // keep truck to our form, for validate. super importent!!!!!!!
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(23.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                    labelText: "Enter Email"
                ),
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),

                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
             new Padding(padding:  EdgeInsets.all(8.0)),
              TextFormField(
                validator: (val) => val.length < 6 ? "Enter valied password" : null,
                decoration: InputDecoration(

                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(23.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                    labelText: "Password"
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                obscureText: true, //for password
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              new Padding(padding:  EdgeInsets.all(8.0)),
              RaisedButton(
                color: Colors.pink[52],
                child: Text('Sign in to EEM',

                style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate())//will check if our from is legit
                      {
                      dynamic result = await _auth.sighinWithEmailAndPassword(email, password);

                    if(result == null) {
                      setState(() =>
                      error = 'please suppp error on register'); //TODO check
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
          )
        ),

      ),
    );
  }
}
*/