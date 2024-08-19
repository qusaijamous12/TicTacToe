import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictokgame/business_layer/cubit/state.dart';

import '../../presentaion_layer/screens/game_screen.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit():super(InitialAppState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool playWithComputer=false;

  String player1='';

  String player2='';

  bool isPlayerOTurn=true;

  List<String> xO=List.generate(9, (index)=>'');

  String messageWinner='';

  bool winner=false;

  //Methods

  late List<int> emptyCells ;
  void computerTurn(context){
   emptyCells= List.generate(9, (i) => i).where((i) => xO[i] == '').toList();
   if(winner==true)
     {
       emit(GameResetState());

     }
   else {
     if (emptyCells.isNotEmpty) {
       final random = Random();
       int move = emptyCells[random.nextInt(emptyCells.length)];
       Future.delayed(Duration(milliseconds: 500), () {
         xO[move] = 'X';
         isPlayerOTurn = true;
         determineWinner(context);
         emit(ComputerTurnState());
       });
     }
   }


  }

  AwesomeDialog buildWinnerDialog(context){
    emit(ShowWinnerDialogState());
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Congratulations You Win!',
        desc: '${messageWinner}',
        btnOkOnPress: () {
          resetGame();

        },
        btnOkText: 'Restart Game'
    )..show();


  }

  void resetGame(){
    xO=[
      '','','','','','','','','',
    ];
    messageWinner='';
    isPlayerOTurn=true;
    winner=false;

    emit(GameResetState());

  }

  Future<void> drawState(context){
    emit(ShowDrawDialogState());
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:const Text(
              'Draw Screen',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
              ),
            ),
            content:const Text(
              'No one winner Draw',
              style:const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                      resetGame();
                    Navigator.pop(context);
                  }, child:const Text(
                  'Restart Game'
              ))
            ],
          );
        });

  }

  bool determineWinner(context){
    //horizontally
    final winningIndices = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6] // diagonals
    ];

    for (var indices in winningIndices) {
      if (xO[indices[0]] == xO[indices[1]] &&
          xO[indices[1]] == xO[indices[2]] &&
          xO[indices[0]] != '') {
        messageWinner = xO[indices[0]] == 'O' ? AppCubit.get(context).player1 : AppCubit.get(context).player2 + ' Won!';

        this.winner= true;
        emit(WinnerState());
        buildWinnerDialog(context);
        return winner;
      }
    }

    if (xO.every((element) => element != '') && messageWinner == '') {
      emit(DrawState());
      drawState(context);
    }
    return winner;



  }

  void handleTab(int index,context){
    if(playWithComputer==true) {
      if (xO[index] == '' && isPlayerOTurn == true) {
        xO[index] = 'O';
        isPlayerOTurn = false;
        emit(OTurn());
        determineWinner(context);
        computerTurn(context);
      }
    }
    else
      {
        if (isPlayerOTurn) {
          if (xO[index] == 'O' ||
              xO[index] == 'X') {} else {
            xO[index] = 'O';
            isPlayerOTurn = false;
            emit(RefreshState());
          }
        } else {
          if (xO[index] == 'O' || xO[index] == 'X') {
          } else {
            xO[index] = 'X';
            isPlayerOTurn = true;
            emit(RefreshState());
          }
        }
        determineWinner(context);
      }




  }



}