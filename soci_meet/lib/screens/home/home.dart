


import 'package:socimeet/models/user.dart';
import 'package:socimeet/services/auth.dart';
import 'package:socimeet/screens/home/HomrManagement';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Home extends StatefulWidget {// he made is stateless but im want it in differ because its will be my menu


  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar :AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Home",
          style:Theme.of(context).textTheme.display1,),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async{
                await _auth.signOut(); // its will set the prividers user to null and wee take as back to the login home page
              },
              icon: Icon(Icons.person),
              label: Text("Out")
          ),


        ],
      ),
      /*appBar: AppBar(
        title: Text('appBar home text'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
      FlatButton.icon(
              onPressed: () async{
                await _auth.signOut(); // its will set the prividers user to null and wee take as back to the login home page
              },
              icon: Icon(Icons.person),
              label: Text('logout')
          )//flat
        ],
      ),*/
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          color: Color(0xFFFFCCBF),
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.83), BlendMode.dstATop),
            image: AssetImage("assets/plaining.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 30 , bottom: 20),
          child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [

                              Colors.orangeAccent.withOpacity(.2),
                              Colors.orangeAccent.withOpacity(.5),
                            ]
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Welcome Back", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "CaviarDreams",
                          fontSize: 32.0,
                          color: Colors.white, ),),
                        Text("Dani and Linoy" , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "CaviarDreams",
                          fontSize: 22.0,
                          color: Colors.white, ),),
                        //Text("Feel free to use the tools below" , style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        /* Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                         // child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                        ),*/
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),

                new Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 20 , bottom: 0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      children: [

                       Container(),
                      ],
                    ),
                  ),
                ),
              ] ),
        ),
      ) ,
    );
  }
}


