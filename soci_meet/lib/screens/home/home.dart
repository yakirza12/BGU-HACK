//import 'dart:html';

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

  static List<Event> userEventsList = [
    // Event(date: DateTime(2020, 9, 14, 17, 30),numberOfParticipants: 50,address: "Rager 155, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 15, 22, 30),numberOfParticipants: 10,address: "Kadesh 12, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe ),
    // Event(date: DateTime(2020, 9, 16, 10, 30),numberOfParticipants: 25,address: "Ben-Matityahu 42, be'er-Sheva",creator: moshe ),
  ];

  static Map<String, User> ulist = {};

  /*A list of users which subscribes to a channel mapped by the channel name */

  static Channel parties =
  Channel(channelName: "Parties", users: ulist, events: userEventsList);
  static Channel shabatDinner = Channel(
      channelName: "Shabat Dinner", users: ulist, events: userEventsList);
  static Channel sport =
  Channel(channelName: "Sport Games", users: ulist, events: userEventsList);
  static List<Channel> arrayChannels = [parties, shabatDinner, sport];

  List<DocumentSnapshot> getDocuments(User user) {
    List<DocumentSnapshot> ds;
    List<DocumentSnapshot> result;
    user.userEventsIdList.forEach((key, value) {
      ds = value.map((doc) =>
          Firestore.instance.collection('Channels').document(key).collection(
              'Events').document(doc).get()).toList();
      result.addAll(ds);
    });
    return result;
  }

  void _buildEventsList(BuildContext context, List<DocumentSnapshot> snapshot) {
    userEventsList.addAll(snapshot.map((data) {
      final Event event = Event.fromSnapshot(data);
      print("this is event " + event.toString());
      return event;
    }).toList());
    /*for (int i = 0; i < userEventsList.length; i++) {
      if (!user.userEventsIdList[channelName]
          .contains(userEventsList[i].eventId)) {
        userEventsList.remove(userEventsList[i]);
        i--;
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
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
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
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
                        child: CategoriesScroller(_user, arrayChannels),
                      ),
                    ),
                    Expanded(
                      child: createUserEventList(_user, arrayChannels),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  createUserEventList(User user, List<Channel> arrayChannels) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Channels')
            .document('Parties')
            .collection('Events')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          else {
            _buildEventsList(context, getDocuments(user));
            return ListView.builder(
                controller: controller,
                itemCount: userEventsList.length,
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
                          child: ChannelState().cardTemplate(userEventsList[
                          index]),
                        ),
                      ));
                });
          }
        });

  /*  Widget updateUserEventList(Channel c, User user) {
      return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('Channels')
              .document(c.channelName)
              .collection('Events')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return LinearProgressIndicator();
            else {
              print("\n\n\nI AM UPDATING THE USER EVENT LIST\n\n\n");
              _buildEventsList(
                  context, getDocuments(user), user, c.channelName);
              return Text("");
            }
          });
    }*/
  }
}

class CategoriesScroller extends StatelessWidget {
  final User login_user;
  final List<Channel> arrayChannels;

  const CategoriesScroller(this.login_user, this.arrayChannels);

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
                                ChannelWidget(login_user, arrayChannels[0])))
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
                            arrayChannels[0].events.length.toString() +
                                " Available Events",
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
                                ChannelWidget(login_user, arrayChannels[1])))
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
                              arrayChannels[1].events.length.toString() +
                                  " Available Events",
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
                                ChannelWidget(login_user, arrayChannels[2])))
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
                            arrayChannels[2].events.length.toString() +
                                " Available Events",
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
                    Spacer(),
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
