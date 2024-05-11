import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slither_snake_on/Pages/Game_Page.dart';
import 'package:slither_snake_on/Pages/Home_Page.dart';

class Game_Over extends StatelessWidget {

  const Game_Over({super.key});



  @override
  Widget build(BuildContext context) {
   int score= GetStorage().read("score");
    return Material(
      color: Colors.yellowAccent.shade200,
      child: SafeArea(

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("GAME"
                ,style: TextStyle(fontSize: 80,color: Colors.brown
                  ),
                ),
                const Text("OVER"
                  ,style: TextStyle(fontSize: 80,color: Colors.brown
                  ),
                ),
                Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Your Score :"
                      ,style: TextStyle(fontSize: 20,color: Colors.brown
                      ),
                    ),
                    Text(score.toString()
                      ,style: TextStyle(fontSize: 20,color: Colors.brown
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                 Container(
         padding: EdgeInsets.only(right: 20,left: 20),
                  decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                      color: Colors.brown

                  ),
                  child: TextButton(
                      onPressed: (){

                        Get.off(()=>Game_Page());
                      }, child: const Text("Restart",style: TextStyle(color: Colors.white,fontSize: 25),)),
                ),
                const SizedBox(height: 30,),
                Container(

                  padding: const EdgeInsets.only(right: 50,left: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.brown

                  ),
                  child: TextButton(
                      onPressed: (){

                        Get.off(()=>Home_Page());
                      }, child: Text("Exit",style: TextStyle(color: Colors.white,fontSize: 25),)),
                ),

                Padding(

                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        const   Text("Share Your",style: TextStyle(fontSize: 25,color: Colors.brown),),
                        const  Text("Score",style: TextStyle(fontSize: 25,color: Colors.brown),),
                        const SizedBox(height: 20,),
                        Container(

                         padding:const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          borderRadius: BorderRadius.circular(50)  
                          ),
                          child: IconButton(onPressed: (){}, icon:const Icon(Icons.share,color: Colors.white
                            ,size: 30,
                            )
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
