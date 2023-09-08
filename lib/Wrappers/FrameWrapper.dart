import 'package:dashboard/Frames/Authentication.dart';
import 'package:dashboard/Frames/MainFrame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FramesWrapper extends StatefulWidget {
  const FramesWrapper({super.key});

  @override
  State<FramesWrapper> createState() => _FramesWrapperState();
}

class _FramesWrapperState extends State<FramesWrapper> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context); 
    
    return user==null? AuthenticationFrame()
    :MainFrame();
  }
}