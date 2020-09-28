import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 고유한 키가 된다.
  final TextEditingController _emailController =
  TextEditingController(); // 컨트롤러를 가지고 텍스트를 가지고 올수있음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password.'),
      ),
      body: Form(
        key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: "Email",
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please input correct Email.";
                  }
                  return null;
                }, // 필드에 작성한 벨류를 갖고와서 벨류가 잘 작성이 되었는지 안되었는지 체크를 해주는 것임
              ),
            FlatButton(onPressed: ()async{
              await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                  final snacBar = SnackBar(
                    content: Text('Check your email for password reset.'),
                  );
                  Scaffold.of(_formKey.currentContext).showSnackBar(snacBar);
            }, child: Text('Reset Password'),)],
      )),
    );
  }
}
