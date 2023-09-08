import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Models/UserClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../Const.dart';
import '../Database/DbHealper.dart';
import '../pages/MainFrame/HomePage.dart';

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  @override
  Widget build(BuildContext context) {
    QuerySnapshot? snapshot=Provider.of(context);
    UserClass? user=null;
    if(snapshot!=null){
      user=getUserInformation(snapshot);
      arduinosList=user.arduinos;
    }
    return snapshot==null? Container(
            child: Center(
              child: SpinKitThreeBounce(
                color: primaryColor,
                size: 40.0,
              ),
            ),
          )
    :StreamProvider<QuerySnapshot?>.value(
              initialData: null,
              value: streamMYArduinos,
              child: HomePage(user: user,)
              );
  }
}