import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tictokgame/presentaion_layer/widgets/widget.dart';



class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Test Audio'
        ),
      ),
      body: Column(
        children: [
          buildButton(
              title: 'Play',
              onpress: ()async{
                final player=AudioPlayer();
                await player.play(AssetSource('audio/soundone.mp3'));


          })
        ],
      ),
    );
  }
}
