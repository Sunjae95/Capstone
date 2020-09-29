import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forget_pw.dart';
import 'join_or_login.dart';
import 'login_background.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 고유한 키가 된다.
  final TextEditingController _emailController =
      TextEditingController(); // 컨트롤러를 가지고 텍스트를 가지고 올수있음
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Size size =
        MediaQuery.of(context).size; // 미디어쿼리 라이브러리를 사용해서 핸드폰 화면 사이즈를 가져오는 것임

    return Scaffold(
      body: Stack(alignment: Alignment.center, children: <Widget>[
        CustomPaint(
          size: size,
          painter:
              LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _logoImage,
            Stack(
              children: <Widget>[
                _inputForm(size),
                _authButton(size),
//                  Container(width: 100,height: 50,color:Colors.black,),
              ],
            ),
            Container(
              height: size.height * 0.1,
            ),
            Consumer<JoinOrLogin>(
              builder: (context, joinOrLogin, child) => GestureDetector(
                  onTap: () {
                    joinOrLogin.toggle();
                  },
                  child: Text(joinOrLogin.isJoin ? "뒤로가기" : "회원 가입",
                      style: TextStyle(
                          fontSize: 20,
                          color:
                              joinOrLogin.isJoin ? Colors.red : Colors.blue))),
            ),
            Container(
              height: size.height * 0.05,
            ),
          ],
        )
      ]),
    );
  }

  void _register(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    // ignore: deprecated_member_use
    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(
        content: Text('Pleas try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _login(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(
        content: Text('Pleas try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Widget get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/logo.jpg"),
            ),
          ),
        ),
      );

  Widget _authButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
        height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin, child) => RaisedButton(
            child: Text(joinOrLogin.isJoin ? "join" : "Login",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            color: joinOrLogin.isJoin ? Colors.red : Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                joinOrLogin.isJoin ? _register(context) : _login(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 16, top: 12, bottom: 32),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: "Email",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Pleas input correct Email.";
                      }
                      return null;
                    }, // 필드에 작성한 벨류를 갖고와서 벨류가 잘 작성이 되었는지 안되었는지 체크를 해주는 것임
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "Password",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Pleas input correct password.";
                      }
                      return null;
                    }, // 필드에 작성한 벨류를 갖고와서 벨류가 잘 작성이 되었는지 안되었는지 체크를 해주는 것임
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, value, child) => Opacity(
                        opacity: value.isJoin ? 0 : 1,
                        child: GestureDetector(
                            onTap: value.isJoin
                                ? null
                                : () {
                                    goToForgetPw(context);
                                  },
                            child: Text("Forgot Password"))),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  goToForgetPw(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPw()));
  }
}
