import 'package:flutter/material.dart';

class GPS extends StatefulWidget {
  @override
  _GPSState createState() => _GPSState();
}

class _GPSState extends State<GPS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        title: Text(
          'GPS',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text('GPS 구현중...'),
      ),
    );
  }
}
