import 'package:socimeet/constants.dart';
import 'package:socimeet/models/user.dart';
import 'package:socimeet/screens/events/partyEvent.dart';
import 'package:socimeet/services/auth.dart';
import 'package:socimeet/screens/home/HomeManagment.dart';
import 'package:flutter/material.dart';
import 'package:socimeet/models/chanel.dart';
import 'package:socimeet/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/chanel.dart';
import '../channel/channel.dart';

class Home extends StatefulWidget {
  // he made is stateless but im want it in differ because its will be my menu

  // ignore: non_constant_identifier_names
  final User login_user;

  // User({this.uid,this.emailAddress,this.first_name,this.last_name,this.gender})
  // Event({this.date, this.numberOfParticipantes, this.address, this.creator});

  const Home(this.login_user);

  User getUser() {
    return login_user;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final AuthService _auth = AuthService();


  static List<Event> userEventsIdList = [
    // Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipants: 50,address: "Rager 155, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipants: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe ),
  ];

  static Map<String, User> ulist = {};/*A list of users which subscribes to a channel mapped by the channel name */

  static Channel parties =
      Channel(channelName: "Parties", users: ulist, events: userEventsIdList);
  static Channel shabatDinner =
      Channel(channelName: "Shabat Dinner", users: ulist, events: userEventsIdList);
  static Channel sport =
      Channel(channelName: "Sport Games", users: ulist, events: userEventsIdList);
  static List<Channel> arrayChannels = [parties, shabatDinner, sport];

  Widget cardTemplate(Event eve,User user) {
    return Card(
        color: Colors.white.withOpacity(.95),
        margin: const EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
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
                user.first_name+" "+ user.last_name,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '${eve.counter} / ${eve.numberOfParticipants}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: (eve.counter == eve.numberOfParticipants)
                      ? Colors.red[900]
                      : Colors.greenAccent,
                ),
              ),
              FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => partyWidget(eve,user)));
                },
                icon: Icon(Icons.info),
                label: Text(''),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double channelHeight = size.height * 0.30;
    User _user = widget.login_user;
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(_user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          } else {
            _user = User.fromSnapshot(snapshot.data, _user.uid);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "SociMeet",
                  style: Theme.of(context).textTheme.display1,
                ),
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () async {
                        await _auth
                            .signOut(); // its will set the prividers user to null and wee take as back to the login home page
                      },
                      icon: Icon(Icons.person),
                      label: Text("Out")),
                ],
              ),

              body: Container(
                height: size.height,
                decoration: BoxDecoration(
                  color: Color(0xFFFFCCBF),
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.83), BlendMode.dstATop),
                    image: AssetImage("assets/friends1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "     Channels",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),

                    /*const SizedBox(
                height: 5,
              ),*/
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 0.8,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: size.width,
                        alignment: Alignment.topCenter,
                        height: channelHeight,
                        child: CategoriesScroller(_user),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            controller: controller,
                            itemCount: userEventsIdList.length,
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              double scale = 1.0;
                              if (topContainer > 0.5) {
                                scale = index + 0.5 - topContainer;
                                if (scale < 0) {
                                  scale = 0;
                                } else if (scale > 1) {
                                  scale = 1;
                                }
                              }
                              return Opacity(
                                  opacity: scale,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..scale(scale, scale),
                                    alignment: Alignment.bottomCenter,
                                    child: Align(
                                      heightFactor: 0.7,
                                      alignment: Alignment.topCenter,
                                      child: cardTemplate(userEventsIdList[index],_user),
                                    ),
                                  ));
                            })),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class CategoriesScroller extends StatelessWidget {
  final User login_user;

  const CategoriesScroller(this.login_user);

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChannelWidget("Parties", login_user)))
                  },
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 20),
                    height: categoryHeight,
                    decoration: BoxDecoration(
                        color: Colors.orange.shade400,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Parties ",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "17 Available Events",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChannelWidget("Shabat Dinner", login_user)))
                  },
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 20),
                    height: categoryHeight,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Shabat Dinner",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "3 Available Events",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChannelWidget("SportGames", login_user)))
                  },
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 20),
                    height: categoryHeight,
                    decoration: BoxDecoration(
                        color: Colors.pink.shade400,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Sport Games",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "12 Available Events",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

/*
  Container(
    alignment: Alignment.bottomLeft,
    child: Column(children: <Widget>[
            ChannelCard(
              itemIndex: 0,
              channel: arryChannels[0],
              press: () {
                Navigator.push(

                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PartiesChannel()
                    )
                );
              },
            ),
            ChannelCard(
              itemIndex: 0,
              channel: arryChannels[1],
              press: () {
                Navigator.push(

                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PartiesChannel()
                    )
                );
              },
            ),
            ChannelCard(
              itemIndex: 0,
              channel: arryChannels[2],
              press: () {
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
          ),
  )*/
        ));
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
        horizontal: size.width / 3.4,
        vertical: 3,
      ),
      // color: Colors.blueAccent,
      height: 50,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomLeft,
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
                tag: '${channel.channelName}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
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
                width: size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        channel.channelName,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    // it use the available space
                    Spacer(), /*
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

/*Padding(
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


                      ],
                    ),

                  ),
                ),*/
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

/*
                    Container(
                      child:Column(children: <Widget>[
                        ChannelCard(
                            itemIndex: 0,
                            channel: arryChannels[0],
                            press: () {
                              Navigator.push(

                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PartiesChannel()
                                  )
                                );
                            },
                      ),
                        ChannelCard(
                          itemIndex: 0,
                          channel: arryChannels[1],
                          press: () {
                            Navigator.push(

                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PartiesChannel()
                                )
                            );
                          },
                        ),
                        ChannelCard(
                          itemIndex: 0,
                          channel: arryChannels[2],
                          press: () {
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
                      )
                      ),


              ] ),
        ),
      ) ,*/
