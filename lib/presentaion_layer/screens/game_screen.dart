import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictokgame/business_layer/cubit/cubit.dart';
import 'package:tictokgame/business_layer/cubit/state.dart';
import 'package:tictokgame/presentaion_layer/widgets/widget.dart';



class GameScreen extends StatelessWidget {
  @override
  ScrollController controllerr = ScrollController();
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      appBar: buildDefaultAppBar(),
      backgroundColor: Colors.deepPurple[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRowDetails(context),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Container(
                  height: 430,
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 20, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[300],
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  child: BlocBuilder<AppCubit,AppState>(
                    builder: (context,state){
                      return GridView.builder(
                        controller: controllerr,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemBuilder: (context, index) =>GestureDetector(
                            onTap: () {
                              AppCubit.get(context).handleTab(index, context);
                              },
                            child: _buildGameArea(cubit.xO[index])),
                        itemCount: 9,
                      );
                    },
                  ),
                ),
              ),
              buildButton(title: 'ResetGame', onpress: () {
                    cubit.resetGame();
                  })
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGameArea(String x) {
    return Container(
      height: 300,
      width: 300,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadiusDirectional.circular(20)),
      child: Text(
        '$x',
        style: TextStyle(
          color: x == 'O' ? Colors.yellow : Colors.red,
          fontSize: 60,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildRowDetails(context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: BlocBuilder<AppCubit,AppState>(
          builder: (context,state){
            return Row(
              children: [
                _buildContainer(AppCubit.get(context).player1,context),
                const Spacer(),
                _buildContainerSecound(AppCubit.get(context).player2,context)
              ],
            );
          },

        ),
      );

  Widget _buildContainer(String name,context) {

    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadiusDirectional.circular(20),
          border: AppCubit.get(context).isPlayerOTurn == true ? Border.all(color: Colors.white, width: 3) :const Border()),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const  Icon(
            Icons.person,
            color: Colors.white,
            size: 60,
          ),
          Text(
            ' ${name}',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerSecound(String name,context) {

    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadiusDirectional.circular(20),
          border: AppCubit.get(context).isPlayerOTurn == false ? Border.all(color: Colors.white, width: 3) :const Border()),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const  Icon(
            Icons.person,
            color: Colors.white,
            size: 60,
          ),
          Text(
            ' ${name}',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ],
      ),
    );
  }



}
