import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictokgame/business_layer/cubit/state.dart';

class AppCubit extends Cubit<InitialAppState>{
  AppCubit():super(InitialAppState());

  static AppCubit get(context)=>BlocProvider.of(context);
  String player1='';
  String player2='';

}