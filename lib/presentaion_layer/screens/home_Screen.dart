import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictokgame/business_layer/cubit/cubit.dart';
import 'package:tictokgame/business_layer/cubit/state.dart';
import 'package:tictokgame/presentaion_layer/screens/game_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController player1controller=TextEditingController();

  TextEditingController player2controller=TextEditingController();

  String player1='';

  String player2='';
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    player1=player1controller.text;
    player2=player2controller.text;
    setState(() {

    });
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Container(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 100),
                    child: Container(
                      width: 220,
                      height: 55,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3
                        ),
                        borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      child:const Text(
                        'WELCOME BACK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding:   EdgeInsets.all(20),
                    child: Image(
                        image:NetworkImage(
                          'https://riwanrandom.wordpress.com/wp-content/uploads/2015/05/tttmarqlrg.gif'
                        ) ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Player 1',
                              filled: true,
                              labelStyle: TextStyle(
                                color: Colors.white
                              ),
                              fillColor: Colors.deepPurple[300]
                            ),
                            style: TextStyle(
                              color: Colors.white
                            ),
                            validator: (String ?value){
                              if(value==null || value.isEmpty){
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            controller: player1controller,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Player 2',
                                filled: true,
                                labelStyle:const TextStyle(
                                  color: Colors.white
                                ),
                                fillColor: Colors.deepPurple[300]
                            ),
                            style:const TextStyle(
                              color: Colors.white
                            ),
                            validator: (String ?value){
                              if(value==null || value.isEmpty){
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            controller: player2controller,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 200),
                    child: Container(
                      width: 160,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 3
                        )
                      ),
                      child: BlocBuilder<AppCubit,AppState>(
                        builder: (context,state){
                          return MaterialButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                AppCubit.get(context).player1=player1controller.text;
                                AppCubit.get(context).player2=player2controller.text;
                                print(AppCubit.get(context).player1);
                                print(AppCubit.get(context).player2);

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GameScreen()));
                                player1controller.text='';
                                player2controller.text='';
                              }
                            },
                            child:const Text(
                              'Start Game',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          );
                        },

                      ),
                    ),
                  )
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
