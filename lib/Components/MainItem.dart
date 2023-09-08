import 'package:dashboard/Database/DbHealper.dart';
import 'package:dashboard/Models/UserClass.dart';
import 'package:flutter/material.dart';

import '../Const.dart';
import '../Models/Arduino.dart';

Widget mainListItem(context, Arduino arduino,UserClass? user) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 20,
              child: Text(arduino.name, style: TextStyle(color: thirdColor,fontSize: 17 ,fontWeight: FontWeight.w400),)
              ),
    
            Positioned(
              bottom: 25,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width-30  ,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 255, 225, 180),
                              radius: 26,
                              child: Center(child: ImageIcon(AssetImage("images/thermometer.png"),color: Color.fromARGB(255, 251, 138, 0),size: 25,)),
                            ),
                            SizedBox(height: 4,),
                            Container(margin: EdgeInsets.only(left: 10,) ,child: Text("${arduino.temperature}°",style: TextStyle(color: Color.fromARGB(255, 251, 138, 0),fontSize: 17),)),
                          ],
                        ),
                        
                        SizedBox(width: 10,),
    
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 162, 211, 251),
                              radius: 26,
                              child: Center(child: ImageIcon(AssetImage("images/humidity.png"),color: Color.fromARGB(255, 0, 136, 254),size: 25,)),
                            ),
                            SizedBox(height: 4,),
                            Container(margin: EdgeInsets.only(left: 10,) ,child: Text("${arduino.humidity}%",style: TextStyle(color: Color.fromARGB(255, 0, 136, 254),fontSize: 17),)),
                          ],
                        ),
    
                        SizedBox(width: 10,),
    
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 252, 236, 171),
                              radius: 26,
                              child: Center(child: ImageIcon(AssetImage("images/luminosity.png"),color: Color.fromARGB(255, 255, 204, 0),size: 25,)),
                            ),
                            SizedBox(height: 4,),
                            Container(margin: EdgeInsets.only(left: 10,) ,child: Text("${arduino.luminosity} LUX",style: TextStyle(color: Color.fromARGB(255, 255, 204, 0),fontSize: 17),)),
                          ],
                        ),
    
                        SizedBox(width: 10,),
    
                        Column(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 219, 183, 169),
                              radius: 26,
                              child: Center(child: ImageIcon(AssetImage("images/Ground Humidity.png"),color: Color.fromARGB(255, 103, 69, 58),size: 25,)),
                            ),
                            SizedBox(height: 4,),
                            Container(margin: EdgeInsets.only(left: 10,) ,child: Text("${arduino.groundHumidity}",style: TextStyle(color: Color.fromARGB(255, 103, 69, 58),fontSize: 17),)),
                          ],
                        ),
                      ],
                    ),
                      ],
                    ),
                ),
              ),

              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close_sharp,size: 28,color: thirdColor,),
                  onPressed: () {
                    user!.arduinos.remove(arduino.id);
                    updateArduinosList(user.arduinos);
                  },
                ),
              )
            
          ],
        ),
      ),
    ),
  );
}
