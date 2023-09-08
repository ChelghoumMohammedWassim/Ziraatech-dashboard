import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Const.dart';
import 'package:dashboard/Database/DbHealper.dart';
import 'package:dashboard/Frames/ScanerFrame.dart';
import 'package:dashboard/Wrappers/AddPageWrapper.dart';
import 'package:dashboard/Wrappers/HomePageWrapper.dart';
import 'package:dashboard/pages/MainFrame/AccountPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';


class MainFrame extends StatefulWidget {
  const MainFrame({super.key});

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {

 int selectedIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex=0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: IndexedStack(
        index: selectedIndex,
        children: [
          StreamProvider<QuerySnapshot?>.value(
            initialData: null,
            value: streamUser,
            child: HomePageWrapper()
          ),
            StreamProvider<QuerySnapshot?>.value(
            initialData: null,
            value: streamUser,
            child: AddPageWrapper()
            ),
          StreamProvider<QuerySnapshot?>.value(
            initialData: null,
            value: streamUser,
            child: AccountPage()
            )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed:() async{
          cameras = await availableCameras();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannerFrame()));
        },
        child: Container(
          child: Image.asset(
            "images/scan.png",
            ),
            height: 30,
        ),
      ),

      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: bgColor,
        activeIndex: selectedIndex,
        splashColor: primaryColor,
        activeColor: primaryColor,
        inactiveColor: Colors.black.withOpacity(0.5),
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.smoothEdge,
        
        iconSize: 28,
        icons: const [
          Icons.home_filled,
          Icons.add_chart_rounded,
          Icons.person
        ],
        onTap: (int index) {  
          setState(() {
            selectedIndex= index;
          });
        },
      )
    );
  }
}