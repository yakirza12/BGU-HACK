import 'package:socimeet/constants.dart';
import 'package:socimeet/models/user.dart';
import 'package:socimeet/services/auth.dart';
import 'package:socimeet/screens/home/HomeManagment.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/event.dart';

import '../../models/chanel.dart';
import '../channel/channel.dart';




class Home extends StatefulWidget {// he made is stateless but im want it in differ because its will be my menu














  final User login_user;
 // User({this.uid,this.emailAddress,this.first_name,this.last_name,this.gender})
 // Event({this.date, this.numberOfParticipantes, this.address, this.creator});

  const Home(this.login_user);

  @override
  _HomeState createState() => _HomeState();

}



class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  static User moshe= User(emailAddress: 'moshe@peretz.com',first_name: 'moshe',last_name: 'peretz',gender: 'male',uid: '42');


  static List<Event> plist = [
    Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipantes: 50,address: "Rager 155, be'er-Sheva",creator: moshe ),
    Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipantes: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
    Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipantes: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe )
  ];


  static Channel parties = Channel(chanelName: "Parties" ,users: {"1" : moshe},events: plist );
  static List<Channel> arryChannels = [parties];





  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar :AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("SociMeet",
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
            image: AssetImage("assets/friends1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 30 , bottom: 20),
          child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [

                              Colors.indigo.withOpacity(.2),
                              Colors.indigo.withOpacity(.7),
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
                        Text( /*widget.login_user.first_name + " " +widget.login_user.last_name */ "Izhak", style: TextStyle(
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
                        // SizedBox(height: 20,),
                        //TODO adding floating action button




                          /*
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top : 150),

                              ),
                              ListView.builder(itemCount : 0 ,itemBuilder:(context,index) =>ChannelCard(
                                itemIndex: 0,
                                channel: arryChannels[0],
                                press: () {
                                  print("kakak");
                                  Navigator.push(

                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                     PartiesChannel()
                                    )

                                  );
                                },
                              ),
                              )


                            ],
                          ),*/




                      ],
                    ),

                  ),
                ),
/*
                new Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 20 , bottom: 0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      children: [
                       /*
                           FloatingActionButton(
                            onPressed: () {Navigator.pushNamed(context, '/shabat');},
                            child: Text('Shabat Dinner'),
                          ),

                        // SizedBox(height: 20,),
                        //TODO adding floating action button

                        FloatingActionButton(
                          autofocus: true,
                          onPressed: () {Navigator.pushNamed(context, '/sport');},
                          child: Text('sport'),
                        ),
                        SizedBox(height: 20,),
                        //TODO adding floating action button

                        FloatingActionButton(
                          onPressed: () {Navigator.pushNamed(context, '/party');},
                          child: Text('Party'),
                        ),*/

                       Container(),
                      ],
                    ),
                  ),
                ),*/
                    Container(



                      child:Column(children: <Widget>[  ChannelCard(
                        itemIndex: 0,
                        channel: arryChannels[0],
                        press: () {
                          print("kakak");
                          Navigator.push(

                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PartiesChannel()
                              )

                          );
                        },
                      ),


                        ]
                        ,)





                      ),


              ] ),
        ),
      ) ,
    );
  }
}



class ChannelCard extends StatelessWidget {
  // list of colors that we use in our app


  const ChannelCard({
    Key key,
    this.itemIndex,
    this.channel,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final Channel channel;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width/3.8,
        vertical: 3,
      ),
      // color: Colors.blueAccent,
      height: 50,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.blue,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Hero(
                tag: '${channel.chanelName}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 0,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 50,
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 50,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        channel.chanelName,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    // it use the available space
                    Spacer(),/*
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "Come",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


