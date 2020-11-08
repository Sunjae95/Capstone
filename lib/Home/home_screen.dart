import 'package:capstone_agomin/Helper/repository.dart';
import 'package:capstone_agomin/Helper/user.dart';
import 'package:capstone_agomin/Home/ChatBot/chatbot_screen.dart';
import 'package:capstone_agomin/Home/GPS/GpsMain.dart';
import 'package:capstone_agomin/Profile/edit_profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Animation/animation_screen.dart';
import 'Follow/friend_screen.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  var _repository = Repository();
  // bool _isGridActive = true;
  Member _user;
  IconData icon;
  Color color;
  // ignore: unused_field
  Future<List<DocumentSnapshot>> _future;
  // bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    retrieveUserDetails();
    icon = FontAwesomeIcons.heart;
  }

  retrieveUserDetails() async {
    User currentUser = await _repository.getCurrentUser();
    Member user = await _repository.retrieveUserDetails(currentUser);
    setState(() {
      _user = user;
    });
    _future = _repository.retrieveUserPosts(_user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Agomin',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Agomin Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('공지사항'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('질문사항'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Agomin 소개'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('로그아웃'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: _user != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/homeColor.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          iconSize: 120.0,
                          icon: IconTheme(
                            data: new IconThemeData(
                              color: null,
                            ),
                            child: Image(
                              image: AssetImage('assets/follower.png'),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ChatScreen())));
                          }),
                      IconButton(
                          iconSize: 120.0,
                          icon: IconTheme(
                            data: new IconThemeData(
                              color: null,
                            ),
                            child: Image(
                              image: AssetImage('assets/animation.png'),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => AgominAnimation())));
                          }),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          width: 200.0,
                          height: 190.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(120.0),
                            image: DecorationImage(
                                image: _user.photoUrl.isEmpty
                                    ? AssetImage('assets/no_image.png')
                                    : NetworkImage(_user.photoUrl),
                                fit: BoxFit.cover),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(_user.displayName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                      ),
                      IconButton(
                        iconSize: 20.0,
                        icon: Icon(Icons.account_box),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => EditProfileScreen(
                                      photoUrl: _user.photoUrl,
                                      email: _user.email,
                                      bio: _user.bio,
                                      name: _user.displayName,
                                      phone: _user.phone))));
                        },
                      ),
                    ],
                  ),
                  Center(
                    // padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                    child: _user.bio.isNotEmpty ? Text(_user.bio) : Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          iconSize: 120.0,
                          icon: IconTheme(
                            data: new IconThemeData(
                              color: null,
                            ),
                            child: Image(
                              image: AssetImage('assets/chatbot.png'),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => AgominChat())));
                          }),
                      IconButton(
                          iconSize: 120.0,
                          icon: IconTheme(
                            data: new IconThemeData(
                              color: null,
                            ),
                            child: Image(
                              image: AssetImage('assets/GPS.png'),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => GpsMain())));
                          }),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
