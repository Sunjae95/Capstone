import 'package:flutter/material.dart';

class AgominAnimation extends StatefulWidget {
  @override
  _AgominAnimationState createState() => _AgominAnimationState();
}

class _AgominAnimationState extends State<AgominAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        title: Text(
          'Animation',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text('Animation 구현중...'),
      ),
    );
  }
}
