import 'package:dashboard/pages/AuthenticationFrame/LoginPage.dart';
import 'package:flutter/material.dart';

class AuthenticationFrame extends StatefulWidget {
  const AuthenticationFrame({super.key});

  @override
  State<AuthenticationFrame> createState() => _AuthenticationFrameState();
}

class _AuthenticationFrameState extends State<AuthenticationFrame> {

  late Widget currentPage;

  updateSelectedPage(Widget page){
    setState(() {
      setState(() {
        currentPage=page;
      });
    });
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage= LoginPage(updateFuction: updateSelectedPage);
  }
  @override
  Widget build(BuildContext context) {
    return currentPage;
  }
}