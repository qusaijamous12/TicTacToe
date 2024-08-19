
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildButton({
 required dynamic title,
  required void Function()? onpress,

})=> Padding(padding:const  EdgeInsets.fromLTRB(20, 20, 20, 20), child: Row(
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
            onPressed: onpress,
            child: Text(
              '${title}',
              style:const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),

    ],
  ),);

PreferredSizeWidget buildDefaultAppBar()=>AppBar(
  backgroundColor: Colors.deepPurple[300],
  elevation: 0,
);

