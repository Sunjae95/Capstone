import 'package:flutter/cupertino.dart';

class JoinOrLogin extends ChangeNotifier{
  bool _isJoin = false;

  bool get isJoin => _isJoin;

  void toggle(){
    _isJoin =!_isJoin;
    notifyListeners(); // 이것을 실행을 하면 changenotifier provider 를 통해서 알림을 보내주는 것이다.
  }
}