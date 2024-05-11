
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:slither_snake_on/Pages/Game_Over_Page.dart';
import 'package:get_storage/get_storage.dart';
class Game_Page extends StatefulWidget {
  const Game_Page({super.key});

  @override
  State<Game_Page> createState() => _Game_PageState();
}

enum Dir{
  right,up,down,left
}
class _Game_PageState extends State<Game_Page> {
  late Timer _timer;
  int score =0;
  late Dir dir;
  int totellives = 5;
  List<int> allborder = [];
 List<int> player=[];
 int foodloc = 0;
  int _row =20;
  int _Column = 20;
  int playerhead=0;
  final store = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetStorage.init();
    gsmestart();

  }
  void updateSnake() {
    setState(() {
      switch (dir) {
        case Dir.up:
          player.insert(0, playerhead - _Column);
          break;
        case Dir.down:
          player.insert(0, playerhead + _Column);
          break;
        case Dir.right:
          player.insert(0, playerhead + 1);
          break;
        case Dir.left:
          player.insert(0, playerhead - 1);
          break;
      }
      player.removeLast();
    });

    playerhead = player.first;
  }
  void gsmestart(){
    borderlinedowncolor();
      player=[45,46,47];
    dir=Dir.right;
      playerhead=player.first;
    foodgen();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {


      updateSnake();
      oncoll();
      foodcoole();
    });
  }

void showgameover(){
    if(totellives==0){
      store.write("score", score);
      Get.off(()=>Game_Over());

    }

}
void foodgen(){
  var rng = Random();
  int tempvalu = rng.nextInt(225);
  if(!allborder.contains(tempvalu)){
    foodloc=tempvalu;
  }

}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
void foodcoole(){
    if(playerhead==foodloc){
      setState(() {
        score++;
        playerhead++;
      });
      foodgen();
    }
}
  void oncoll(){
    if(allborder.contains(player.last)){
      setState(() {
        totellives=totellives-1;
        player.clear();
        player=[45,46,47];
        playerhead=player.first;
        dir=Dir.right;
        foodgen();
      });
      showgameover();
    }
  }
  void borderlinedowncolor(){

    for(int i=(_row*_Column)-_Column;i<_row*_Column;i=i+1){
      if(!allborder.contains(i))allborder.add(i);
    }
    for(int i=_Column-1;i<_row*_Column;i=i+_Column){
      if(!allborder.contains(i))allborder.add(i);
    }
    for(int i=0;i<_row*_Column;i=i+_Column){
      if(!allborder.contains(i))allborder.add(i);
    }
    for(int i=0;i<_Column;i++){
     if(!allborder.contains(i)) allborder.add(i);
    }


  }
  @override
  Widget build(BuildContext context) {
Color fillcolor(int index){
  if(allborder.contains(index)){
    return Colors.redAccent;
  }
  else{
    if(player.contains(index)){
      return Colors.green;
    }else{
      if(index==foodloc)
      return Colors.orange;
    }
    return Colors.brown;
  }


}

    return  Material(
      color: Colors.yellowAccent.shade200,
      child:Scaffold(
        appBar: AppBar(
          title: Text("Slither Snake",style: TextStyle(color: Colors.brown,fontSize: 25),),
          centerTitle: true,
          backgroundColor: Colors.yellowAccent.shade200,
        ),
        body: Material(
          color:  Colors.yellowAccent.shade200,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(

              children: [
                 SizedBox(
                   height: 50,
                   child: Padding(

                     padding: EdgeInsets.all(8.0),
                     child: Row(

                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Score :",style: TextStyle(color: Colors.brown ,fontSize: 20),),
                         Text(score.toString(),style: TextStyle(color: Colors.brown ,fontSize: 20)),
                         Spacer(),
                         Text(totellives.toString(),style: TextStyle(color: Colors.brown ,fontSize: 20)),
                         Icon(Icons.heart_broken,color: Colors.red,size: 30,),

                       ],
                     ),
                   ),
                 ),
             Container(
               height: 440,
               margin: EdgeInsets.all(5),
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.black),
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _Column

                 ),
                     itemCount: _row*_Column
                     ,itemBuilder: (context,index){
                   return Padding(
                     padding: const EdgeInsets.all(1),
                     child: Container(

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5)
                             ,color: fillcolor(index)
                       ),
                     ),
                   );
                 }),
               ),
             ),

              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20,left: 20),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextButton(
                          onPressed: (){
                            if(dir!=Dir.down) {
                              setState(() {
                              dir=Dir.up;
                            });
                            }
                          }, child: Text("UP",style: TextStyle(color: Colors.white,fontSize: 25),)),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      Container(
                        padding: EdgeInsets.only(right: 20,left: 20),
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextButton(
                            onPressed: (){
                              if(dir!=Dir.right) {
                                setState(() {
                                  dir=Dir.left;
                                });
                              }
                            }, child: Text("Left",style: TextStyle(color: Colors.white,fontSize: 25),)),
                      ),
                      SizedBox(width: 50,),
                      Container(
                        padding: EdgeInsets.only(right: 20,left: 20),
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TextButton(
                            onPressed: (){
                              if(dir!=Dir.left) {
                                setState(() {
                                  dir=Dir.right;
                                });
                              }
                            }, child: Text("Right",style: TextStyle(color: Colors.white,fontSize: 25),)),
                      ),
                    ],),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(right: 20,left: 20),
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextButton(
                          onPressed: (){
                            if(dir!=Dir.up) {
                              setState(() {
                                dir=Dir.down;
                              });
                            }
                          }, child: Text("Down",style: TextStyle(color: Colors.white,fontSize: 25),)),
                    ),


                  ],
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


