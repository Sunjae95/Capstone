import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name;
  int age;
  String species;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          '프로필 설정',
          textAlign: TextAlign.center,
        )),
        body: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('이미지추가'),
                onPressed: () {},
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text('이름'),
                  ),
                  Flexible(
                    child: TextField(
                      onChanged: (text) {
                        name = text;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text('나이'),
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        var tmp = int.parse(text);
                        age = tmp;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text('견종'),
                  ),
                  Flexible(
                    child: TextField(
                      onChanged: (text) {
                        species = text;
                      },
                    ),
                  ),
                ],
              ),
              RaisedButton(
                child: Text('확인'),
                onPressed: () {
                  var input = ProfileSet(
                    name: name,
                    age: age,
                    species: species,
                  );
                  print(input.name + '${input.age}' + input.species);
                  Navigator.pop(context, input);
                },
              ),
            ],
          ),
        ));
  }
}

class ProfileSet {
  String name;
  int age;
  String species;

  ProfileSet({
    this.name,
    this.age,
    this.species,
  });
}
