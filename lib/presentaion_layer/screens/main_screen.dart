import 'package:flutter/material.dart';
import 'package:tictokgame/business_layer/cubit/cubit.dart';
import 'package:tictokgame/presentaion_layer/screens/game_screen.dart';
import 'package:tictokgame/presentaion_layer/screens/home_Screen.dart';
import 'package:tictokgame/presentaion_layer/widgets/widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.deepPurple,
      appBar:buildDefaultAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(
                title: 'Play MultiPlayer',
                onpress: (){
                  AppCubit.get(context).playWithComputer=false;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                }),
            buildButton(
                title: 'Play With Computer',
                onpress: (){
                  AppCubit.get(context).playWithComputer=true;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GameScreen()));

                })
          ],
        ),

      )

    );
  }
}
