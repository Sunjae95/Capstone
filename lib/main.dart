import 'package:capstone_agomin/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
            return page(); //내꺼 페이지넣어야됨
          }
        });
  }
}

class page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
