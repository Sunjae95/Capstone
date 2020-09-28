import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../mainPage.dart';
import 'loading_page.dart';
import 'login_page.dart';
import 'tab_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('root_page created');
    return _handleCurrentScreen();
  }


  Widget _handleCurrentScreen() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // 연결 상태가 기다리는 중이라면 로딩 페이지를 반환
        if(snapshot.connectionState ==ConnectionState.waiting) {
          return LoadingPage();
        }else{
          //연결되었고 데이터가 있다면
          if (snapshot.hasData) {
            return TabPage(snapshot.data);
          }
          return LoginPage();
        }
      },);
  }


}

