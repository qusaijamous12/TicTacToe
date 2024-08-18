import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictokgame/business_layer/cubit/cubit.dart';
import 'package:tictokgame/business_layer/cubit/state.dart';

class GameScreen extends StatefulWidget {


  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  ScrollController controllerr=ScrollController();
  List<String> xO=[
    '','','','','','','','','',
  ];
  bool myTurn=true;
  String messageWinner='';
  bool winner=false;
  int index=0;

  List<Offset?> points = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildDefaultAppBar(),
      backgroundColor: Colors.deepPurple[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRowDetails(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 40
                ),
                child: Container(
                  height: 430,
                  padding:const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                    top: 20,
                    bottom: 5
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadiusDirectional.circular(20)
                  ),
                  child: GridView.builder(
                    controller:controllerr ,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5

                      ),
                      itemBuilder: (context,index)=>GestureDetector(
                         onTap: (){
                          if(myTurn) {
                            if(xO[index]=='O'||xO[index]=='X'){

                            }else {
                              xO[index] = 'O';
                              myTurn = false;
                            }
                          }
                          else {
                            if(xO[index]=='O'||xO[index]=='X'){

                            }
                            else
                              {
                                xO[index] = 'X';
                                myTurn=true;
                              }

                          }
                          _determineWinner();
                          setState(() {

                          });
                        },
                          child: _buildGameArea(xO[index])),
                    itemCount: 9,
                  ),
                ),
              ),
              _buildResetButton()
          
            ],
          ),
        ),
      ),


    );
  }

  Widget _buildGameArea(String x){
    return Container(
      height: 300,
      width: 300,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Text(
        '$x',
        style: TextStyle(
          color: x=='O'?Colors.yellow:Colors.red,
          fontSize: 60,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

  }

  void _determineWinner(){
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
        _buildWinnerDialog(context);
        return;
      }
    }

    if (xO.every((element) => element != '') && messageWinner == '') {
      _drawState(context);
    }



  }

  AwesomeDialog _buildWinnerDialog(context){
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Congratulations You Win!',
        desc: '${messageWinner}',
    btnOkOnPress: () {
          resetGame();
          setState(() {

          });

    },
      btnOkText: 'Restart Game'
    )..show();


  }

  Future<void> _drawState(context){
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
                    setState(() {
                      resetGame();
                    });
                    Navigator.pop(context);
                  }, child:const Text(
                  'Restart Game'
              ))
            ],
          );
        });

  }

  void resetGame(){
    xO=[
      '','','','','','','','','',
    ];
    messageWinner='';
    myTurn=true;
    setState(() {

    });
  }

  Widget _buildContainer(String name){
    return  Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadiusDirectional.circular(20),
          border:myTurn==true?Border.all(color: Colors.white,width: 3):Border()
      ),
      child: BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                 Icons.person,
                 color: Colors.white,
                   size: 60,
               ),
              Text(
                ' ${AppCubit.get(context).player1}',
                style:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),

            ],
          );
        },

      ),
    );
  }

  Widget _buildContainerSecound(String name){
    return   Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadiusDirectional.circular(20),
          border:myTurn==false?Border.all(color: Colors.white,width: 3):Border()

      ),
      child: BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                 Icons.person,
                 size: 60,
                 color: Colors.white,
               ),
              Text(
                ' ${AppCubit.get(context).player2}',
                style:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),

            ],
          );
        },

      ),
    );
  }

  PreferredSizeWidget _buildDefaultAppBar()=>AppBar(
    backgroundColor: Colors.deepPurple[300],
    elevation: 0,
  );

  Widget _buildRowDetails()=>Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
    child: Row(
      children: [
        _buildContainer('Player 1'),
        Spacer(),
        _buildContainerSecound('Player 2')
      ],
    ),
  );

  Widget _buildResetButton()=> Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadiusDirectional.circular(20),
                border: Border.all(
                    color: Colors.white,
                    width: 3
                )

            ),
            child: MaterialButton(
              onPressed: (){
                resetGame();
              },
              child:const Text(
                'Reset Game',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),

      ],
    ),
  );

}

// class BlockPainter extends CustomPainter {
//   final String drawType;
//
//   BlockPainter(this.drawType);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.white
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0
//     ..style=PaintingStyle.stroke;
//
//     if (drawType == 'O') {
//       canvas.drawCircle(size.center(Offset.fromDirection(5)), size.width / 2, paint);
//     } else if (drawType == 'X') {
//       double offset = 20; // Same as the radius of the circle
//       canvas.drawLine(
//         Offset(size.width / 2 - offset / 2, size.height / 2 - offset / 2),
//         Offset(size.width / 2 + offset / 2, size.height / 2 + offset / 2),
//         paint
//           ..strokeWidth = 5,
//       );
//       canvas.drawLine(
//         Offset(size.width * 3 / 4, size.height / 4),
//         Offset(size.width / 4, size.height * 3 / 4),
//         paint,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}


