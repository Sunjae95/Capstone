import 'package:capstone_agomin/Login/main_page.dart';
import 'package:capstone_agomin/Sns/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatBot/chatScreen.dart';
import 'Profile/profileScreen.dart';
import 'Sns/loading_page.dart';
import 'Sns/login_page.dart';
import 'Sns/tab_page.dart';

class MainPage extends StatelessWidget {
  var profileSet = ProfileSet(name: "name", age: 0, species: "species");

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 150,
                ),
                child: Text('이미지칸'),
              ),
              Container(
                child: Text('이름: ${profileSet.name}\n'
                    '나이: ${profileSet.age}\n'
                    '견종: ${profileSet.species}\n'),
              ),
              Container(
                  margin: EdgeInsets.only(
                    bottom: 150,
                  ),
                  child: RaisedButton(
                      child: Text('프로필칸으로 이동'),
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Profile();
                          },
                        ));
                      })),
              Container(
                //alignment: ,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: Text('친구'),
                        color: Colors.amber,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: RaisedButton(
                            child: Text('ChatBot'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    AgominChat()),
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 40,
                        ),
                        child: RaisedButton(
                            child: Text('SNS'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RootPage()),
                                //TabPage(snapshot.data)), //페이지 추가
                              );
                            }),
                      ),
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

