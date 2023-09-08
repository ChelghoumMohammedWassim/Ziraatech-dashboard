import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/pages/MainFrame/AddPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../Const.dart';
import '../Database/DbHealper.dart';
import '../Models/UserClass.dart';

class AddPageWrapper extends StatefulWidget {
  const AddPageWrapper({super.key});

  @override
  State<AddPageWrapper> createState() => _AddPageWrapperState();
}

class _AddPageWrapperState extends State<AddPageWrapper> {
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
              value: streamArduinos,
              child: AddPage(user: user,)
              );
  }
}