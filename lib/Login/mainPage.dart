import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:capstone_agomin/ChatBot/chatScreen.dart';
import 'package:capstone_agomin/Profile/profileScreen.dart';
import 'package:capstone_agomin/Sns/tab_page.dart';

class MainPage extends StatelessWidget {
  //var profileSet = ProfileSet(name: "name", age: 0, species: "species");

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/logo.jpg'),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                bottom: 150,
              ),
              child: RaisedButton(
                  child:
                      Text('${FirebaseAuth.instance.currentUser.displayName}'),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return Profile();
                      },
                    ));
                  })),
          Container(
              padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 6,
                              blurRadius: 4),
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.assignment_ind),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgominChat()),
                                  );
                                }),
                            Text(
                              '친구',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 6,
                              blurRadius: 4),
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.assignment_ind),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgominChat()),
                                  );
                                }),
                            Text(
                              '챗봇',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 6,
                              blurRadius: 4),
                        ]),
                    child: Column(
                      children: <Widget>[
                        StreamBuilder(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.assignment_ind),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TabPage(snapshot.data)),
                                                //TabPage(snapshot.data)), //페이지 추가
                                              );
                                            }),
                                        Text(
                                          'SNS',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ));
                              }
                            })
                        // Icon(
                        //   Icons.account_circle,
                        //   color: Colors.black,
                        // ),
                        // Text(
                        //   'SNS',
                        //   style: TextStyle(color: Colors.black),
                        // )
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     left: 40,
                  //   ),
                  //   child: StreamBuilder(
                  //       stream: FirebaseAuth.instance.authStateChanges(),
                  //       builder: (BuildContext context,
                  //           AsyncSnapshot<dynamic> snapshot) {
                  //         {
                  //           return RaisedButton(
                  //               child: Text('SNS'),
                  //               onPressed: () {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (context) =>
                  //                           TabPage(snapshot.data)),
                  //                   //TabPage(snapshot.data)), //페이지 추가
                  //                 );
                  //               });
                  //         }
                  //       }),
                  // )
                ],
              )),
        ],
      )),
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
            SizedBox(
              height: 280,
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
    );
  }
}
