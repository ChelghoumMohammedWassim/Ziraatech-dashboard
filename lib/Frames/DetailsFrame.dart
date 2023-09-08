import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Const.dart';
import 'package:dashboard/Database/DbHealper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../Models/Arduino.dart';

class DetailsFrame extends StatefulWidget {
  const DetailsFrame({super.key});

  @override
  State<DetailsFrame> createState() => _DetailsFrameState();
}

class _DetailsFrameState extends State<DetailsFrame> {
  // Arduino arduino=Arduino(id: "id",name: "name", humidity: 0, luminosity: 0, groundHumidity: 0, temperature: 0, fansSpeed: 30,light: true);
  TextEditingController nameControler = TextEditingController();
  String initvalue = "";
  @override
  Widget build(BuildContext context) {
    QuerySnapshot? snapshot = Provider.of(context);
    Arduino? arduino = null;
    if (snapshot != null) {
      List<Arduino> list = snapshotTOAruinosList(snapshot);
      arduino = list[0];
      initvalue = arduino.name;
    }
    FocusNode myfocus = FocusNode();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: thirdColor,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Image.asset(
                "images/logo.png",
                height: 40,
              ),
            ],
          ),
        ),
      ),
      body: arduino == null
          ? Container(
              child: Center(
                child: SpinKitThreeBounce(
                  color: primaryColor,
                  size: 40.0,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: nameControler,
                      focusNode: myfocus,
                      onEditingComplete: () {
                        if(nameControler.text.isNotEmpty){
                            updateArduino(
                            "name",
                            nameControler.text,
                            selectedArduinoID);
                            nameControler.clear();
                            
                        }
                        myfocus.unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: arduino.name,
                        icon: Icon(Icons.abc),
                        border: InputBorder.none,
                        focusColor: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: SleekCircularSlider(
                                initialValue: arduino.desiredTemperature,
                                innerWidget: (double value) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Necessary  temperature",
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.height*0.02),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        " ${arduino!.desiredTemperature}C°",
                                        style: TextStyle(
                                            color: thirdColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.height*0.04),
                                      )
                                    ],
                                  );
                                },
                                appearance: CircularSliderAppearance(
                                  
                                  size: MediaQuery.of(context).size.height *
                                      0.3,
                                  animationEnabled: true,
                                  customWidths: CustomSliderWidths(
                                      trackWidth: 8, progressBarWidth: 14),
                                  customColors: CustomSliderColors(
                                      progressBarColors: [
                                        Colors.green.withOpacity(1),
                                        Colors.green.withOpacity(0.9),
                                        Colors.green.withOpacity(0.7),
                                        Colors.green.withOpacity(0.5),
                                        Colors.green.withOpacity(0.3),
                                        Colors.green.withOpacity(0.1)
                                      ],
                                      trackColor:
                                          Colors.grey.withOpacity(0.3)),
                                ),
                                onChange: (double value) {
                                  //set value in database
                                  updateArduino(
                                      "desiredTemperature",
                                      double.parse(value.toStringAsFixed(1)),
                                      selectedArduinoID);
                                })),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Row(
                                                children: [
                                                  ImageIcon(
                                                    AssetImage("images/Ground Humidity.png"),
                                                    color: Colors.brown,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Necessary Ground Humidity",
                                                    style: TextStyle(fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                    "${arduino.desiredGroundHumidity}",
                                                    style: TextStyle(fontSize: 17,color: Colors.brown[400],fontWeight: FontWeight.w600),
                                                  ),
                                            ],
                                          ),
                                          Slider(
                                            value: arduino.desiredGroundHumidity,
                                            min: 0,
                                            max: 1000,
                                            divisions: 100,
                                            activeColor:  const Color.fromARGB(255, 144, 108, 95),
                                            onChanged: (value){
                                              updateArduino ("desiredGroundHumidity",
                                              double.parse(value.toStringAsFixed(1)),
                                              selectedArduinoID);
                                            }
                                            )
                                        ],
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Row(
                                                children: [
                                                  ImageIcon(
                                                    AssetImage("images/luminosity.png"),
                                                    color: Colors.amber,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Necessary luminosity",
                                                    style: TextStyle(fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                    "${arduino.light}%",
                                                    style: TextStyle(fontSize: 17,color: Colors.brown[400],fontWeight: FontWeight.w600),
                                                  ),
                                            ],
                                          ),
                                          Slider(
                                            value: arduino.light,
                                            min: 0,
                                            max: 100,
                                            divisions: 20,
                                            activeColor:  Colors.yellow[600],
                                            onChanged: (value){
                                              updateArduino ("light",
                                              double.parse(value.toStringAsFixed(1)),
                                              selectedArduinoID);
                                            }
                                            )
                                        ],
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [
                            Column(
                              children: [
                                Text(
                                  "humidity",
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${arduino.humidity}",
                                  style: TextStyle(
                                      color: thirdColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            SizedBox(height: 18,),
                            Column(
                              children: [
                                Text(
                                  "ground humidity",
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${arduino.groundHumidity}",
                                  style: TextStyle(
                                      color: thirdColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            SizedBox(height: 18,),
                            Column(
                              children: [
                                Text(
                                  "luminosity",
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${arduino.luminosity} LUX",
                                  style: TextStyle(
                                      color: thirdColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            )
            ),
    );
  }
}
