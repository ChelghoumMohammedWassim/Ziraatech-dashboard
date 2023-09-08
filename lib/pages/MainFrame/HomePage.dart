import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Const.dart';
import 'package:dashboard/Database/DbHealper.dart';
import 'package:dashboard/Models/Arduino.dart';
import 'package:dashboard/Models/UserClass.dart';
import 'package:dashboard/Wrappers/DeatilsFrameWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Components/MainItem.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  UserClass? user;
  HomePage({super.key,required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    QuerySnapshot? snapshot=Provider.of(context);
    List<Arduino> list=[];
    if(snapshot!=null){
      list=snapshotTOAruinosList(snapshot);
    }
    return snapshot==null && widget.user==null? Container(
            child: Center(
              child: SpinKitThreeBounce(
                color: primaryColor,
                size: 40.0,
              ),
            ),
          )
    :Container(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: Container(
              padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [primaryColor, Colors.greenAccent]),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Lottie.asset(
                            'images/67846-tomato-animation.json',
                            repeat: false,
                            animate: true,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 34, left: 30),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset("images/logo.png",height: 40,),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Ziraatech",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300),
                                ),
                                
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Learn More",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "about your plants",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 150,
                              height: 2,
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
                ),
          ),

          list.length>0? SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: list.length,
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedArduinoID=list[index].id;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsFrameWrapper()));
                  },
                  child: mainListItem(context,list[index],widget.user)
                );
            }
            ),
          ):
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height-250,
            backgroundColor: Colors.transparent,
            flexibleSpace: Center(
              child: Text("you don't have any tracked plants",style: TextStyle(color: thirdColor),),
            ),
          )
        ],
      ),
    );
  }
}
