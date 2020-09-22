import 'package:capstone_agomin/screens/login.dart';
import 'package:capstone_agomin/screens/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'ChatBot/chatScreen.dart';
import 'Profile/profileScreen.dart';
import 'data/join_or_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Splash(),
  ));
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // ignore: deprecated_member_use
    return StreamBuilder<User>(
        // ignore: deprecated_member_use
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
              value: JoinOrLogin(),
              child: AuthPage(),
            );
          } else {
            return MainPage(); //내꺼 페이지넣어야됨
          }
        });
  }
}

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
                        MaterialPageRoute(builder: (context) => AgominChat()),
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
                            builder: (context) => InstagramApp()), //페이지 추가
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
          ],
        ),
      ),
    );
  }
}
