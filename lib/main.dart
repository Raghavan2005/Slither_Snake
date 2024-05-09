import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Start(),
      theme: ThemeData(
        fontFamily: "Anton"
      ),

    )
  );
}
class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}
 enum Dir{
  Right,Left,Up,Down
}

class _DashState extends State<Dash> {
  int _row = 15;
  int _column = 15;
  Dir dir = Dir.Right;
  int headcount = 0;
  int sor = 0;
  late Timer _timer;
int food = 18;
 List<int> player = [18,17,16];
 @override
  void initState() {
   borderlineupcolor();
   borderlinerightcolor();
   borderlineleftcolor();
   borderlinedowncolor();
  // updatestatus();
  // updatelocation();
   genfood();
   headcount=player.first;

   _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
     updatestatus();
    updatelocation();
     collcheck();
   });
    super.initState();
  }
  void genfood(){
    var rng = Random();
    setState(() {
      food =rng.nextInt(100);
    });


  }

  void updatelocation() {
int first=0;
   headcount=player.last;
    switch (dir) {
      case Dir.Up:
        player.insert(0, headcount - _column);
        break;
      case Dir.Down:
        player.insert(0, headcount + _column);
        break;
      case Dir.Right:
        player.insert(0, headcount + 1);
        break;
      case Dir.Left:
        player.insert(0, headcount - 1);
        break;
    }
if (headcount == food) {
  sor++;
  genfood();
} else {
 player.removeLast();
}

headcount = player.first;
  }

void collcheck(){
   if(food==player.last){
     genfood();
     sor++;
   }
   if(allborder.contains(headcount)){
     _timer.cancel();
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) =>  gameover()),);
   }

}
  void updatestatus(){
   if(player[2]!=208){
     setState(() {
       player[0]=player[0]+1;
       player[1]=player[1]+1;
       player[2]=player[2]+1;
     });
   }else{
     setState(() {
       player[0]=16;
       player[1]=17;
       player[2]=18;
     });
   }


  }
@override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

 List<int> allborder = [];
void borderlineupcolor(){

   for(int i=0;i<=14;i++){
     allborder.add(i);
   }


}
  void borderlinerightcolor() {

    for(int i=29;i<=209;i=i+15){
      allborder.add(i);
    }


  }
  void borderlineleftcolor(){

    for(int i=15;i<=195;i=i+15){
      allborder.add(i);
    }


  }
  void borderlinedowncolor(){

    for(int i=210;i<=224;i++){
      allborder.add(i);
    }


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: const Text("Game Area"),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: ()  {
            setState(() {
              player[0]=16;
              player[1]=17;
              player[2]=18;
            });
            }, icon: Icon(Icons.wifi_tethering_sharp))
        ],
        flexibleSpace: SafeArea(child: Center(child: Text(sor.toString()))),
      ),
      body: SafeArea(
        child: bodymap(),
      ),
    );
  }
Color fillcolor(int index){

  if(allborder.contains(index)){

    return Colors.red;
  }
  else{
    if(player.contains(index)){
      if(headcount==index){
        return Colors.yellow;
      }
      return Colors.yellow;
    }
    if(index==food){
      return Colors.green;
    }
    return Colors.grey.withOpacity(0.90);
  }


}

  Column bodymap() {
    return Column(
      children: [
        Container(

          height: 460,
            width: double.infinity,
            color: Colors.cyan,
          child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 15,
          ),
              itemCount: _row*_column,
               itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                 margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: fillcolor(index)

                  ),
//child: Text(index.toString()),

                ),


            );
              }
          )
          ),
Container(
  height: 370,
  width: double.infinity,
  color: Colors.green,
  child: Column(
    children: [
      SizedBox(height: 100,),
      ElevatedButton(
        onPressed: (){
        setState(() {
          dir=Dir.Up;

        });

      }, child: Text("Up"),),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
              setState(() {
                dir=Dir.Left;
              });

            }, child: Text("Left"),),
          SizedBox(width: 30),
          ElevatedButton(onPressed: (){
            setState(() {
              dir=Dir.Right;
            });

          }, child: Text("Right"),),
        ],
      ),
      ElevatedButton(onPressed: (){
        setState(() {
          dir=Dir.Down;

        });

      }, child: Text("Down"),),


    ],
  ),
)
      ],
    );
  }
}



class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SafeArea(child: Container(
        width: double.infinity,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Image.asset('asset/images/startimg.png',width: 200,height: 300,),
            Text("Slither Snake",style: TextStyle(
              fontSize: 50
            ),),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Dash()),
              );
            }, child: Text("Start Game" , style: TextStyle(
              fontSize: 30
            ),)),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              SystemNavigator.pop();

            }, child: Text("Exit Game", style: TextStyle(
                fontSize: 30
            ))),
          ],
        ),
      )),
    );
  }
}

class gameover extends StatelessWidget {

  int sor=0;
   gameover({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  SafeArea(child: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('asset/images/gameover.png',width: 300,),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dash()),);
            }, child: Text("Try again", style: TextStyle(
                fontSize: 30
            ))),
            SizedBox(height: 20,)
            ,
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Start()),);
            }, child: Text("Return To Menu", style: TextStyle(
                fontSize: 30
            )))
          ],
        ),
      )),
    );
  }
}
