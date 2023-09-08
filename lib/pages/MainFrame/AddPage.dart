import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Models/UserClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../Const.dart';
import '../../Database/DbHealper.dart';
import '../../Models/Arduino.dart';

// ignore: must_be_immutable
class AddPage extends StatefulWidget {
  UserClass? user;
   AddPage({super.key,required this.user});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  
  TextEditingController inputController=TextEditingController();
  String input='°';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                      color: bgColor, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: inputController,
                    onChanged: (value) {
                      setState(() {
                        input=value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ID Code...',
                      icon: Icon(Icons.connected_tv_rounded),
                      border: InputBorder.none,
                      focusColor: Colors.grey,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return input.length>10 && list[index].id.startsWith(input) ?Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index].id,maxLines: 1,overflow: TextOverflow.fade,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                      SizedBox(height: 5,),
                                      Text(list[index].name,maxLines: 1,overflow: TextOverflow.fade,style: TextStyle(color: thirdColor,fontSize: 16,fontWeight: FontWeight.w300),),
                                    ],
                                  ),

                                  IconButton(
                                    icon: Icon(Icons.track_changes_rounded ,size: 30,color: !widget.user!.arduinos.contains(list[index].id)? thirdColor: Colors.green[300],),
                                    onPressed: () {
                                      if(!widget.user!.arduinos.contains(list[index].id)){
                                        widget.user!.arduinos.add(list[index].id);
                                        updateArduinosList(widget.user!.arduinos);
                                      }
                                    },
                                  )
                            ],
                          ),
                        ),
                      ):
                      Container();
                    },
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
