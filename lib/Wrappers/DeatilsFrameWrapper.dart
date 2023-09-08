import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Frames/DetailsFrame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Database/DbHealper.dart';

class DetailsFrameWrapper extends StatefulWidget {
  const DetailsFrameWrapper({super.key});

  @override
  State<DetailsFrameWrapper> createState() => _DetailsFrameWrapperState();
}

class _DetailsFrameWrapperState extends State<DetailsFrameWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: streamArduinosDrtails,
      initialData: null,
      child: DetailsFrame(),
      );
  }
}