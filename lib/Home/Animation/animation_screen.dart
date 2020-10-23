import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class AgominAnimation extends StatefulWidget {
  @override
  _AgominAnimationState createState() => _AgominAnimationState();
}

class _AgominAnimationState extends State<AgominAnimation> {
  final AudioCache _player = AudioCache();

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
      body: Container(
        child:Column(children: [
          RaisedButton(
          child: Text('clicker'),
          onPressed: () {
            _player.play('click.mp3');
          },
        ),
        RaisedButton(
          child: Text('좋은 음악'),
          onPressed: () {
            _player.play('click.mp3');
          },
        ),
        RaisedButton(
          child: Text('수면음악'),
          onPressed: () {
            _player.play('click.mp3');
          },
        ),
        ],),
        
      ),
    );
  }
}
