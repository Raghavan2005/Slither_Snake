import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slither_snake_on/Pages/Game_Page.dart';
class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child:
    Material(
      color: Colors.yellowAccent.shade200 ,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://www.freepnglogos.com/uploads/safari-png/safari-zoo-snake-picture-35.png",width: 300,height: 300,),
           SizedBox(height: 50,),
            Container(
              padding: EdgeInsets.only(right: 5,left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                 color: Color.fromRGBO(126, 34, 2, 100)
                     
              ),
              child: TextButton(
                  onPressed: (){
                    Get.off(Game_Page());
              }, child: Text("Play Now",style: TextStyle(color: Colors.white,fontSize: 35),)),
            )
            ,
            SizedBox(height: 30),
            Column(
              children: [
                Text("Instructions:",style: TextStyle(color: Color.fromRGBO(244, 101, 101, 100) ,fontSize: 25),),
                SizedBox(height: 10),
                Text('Keep Eye on Walls.',style: TextStyle(color: Colors.black ,fontSize: 20)),
                Text('Eat Food To Grow.',style: TextStyle(color: Colors.black  ,fontSize: 20)),
                Text('Stay Alive.',style: TextStyle(color: Colors.black  ,fontSize: 20)),
              ],
            )
          ],
        ),
      ),
    )
    );
  }
}
