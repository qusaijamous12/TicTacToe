import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictokgame/business_layer/cubit/cubit.dart';
import 'package:tictokgame/presentaion_layer/screens/game_screen.dart';
import 'package:tictokgame/presentaion_layer/screens/home_Screen.dart';
import 'package:tictokgame/presentaion_layer/screens/main_screen.dart';
import 'package:tictokgame/test/test.dart';

import 'business_layer/observer.dart';

void main() {

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>AppCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home:TestScreen()

      ),
    );
  }
}
