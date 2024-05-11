import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slither_snake_on/Pages/Game_Over_Page.dart';
import 'package:slither_snake_on/Pages/Game_Page.dart';
import 'package:slither_snake_on/Pages/Home_Page.dart';

void main(){
  runApp( GetMaterialApp(
debugShowCheckedModeBanner: false,
    home:  Game_Page(),
    theme: ThemeData(
      fontFamily: "KronaOne"
    ),
  ));
}