import 'package:dashboard/Const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  final Function updateFuction;
  LoginPage({super.key, required this.updateFuction});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email_error;
  late String password_error;
  late bool loding;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email_error = 'Done';
    password_error = 'Done';
    loding = false;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email_input = TextEditingController();
    TextEditingController password_input = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  child: Lottie.asset(
                    'images/129793-afro-man-farmer-online-agriculture-service-application-wheat-fields-growth.json',
                    repeat: true
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'HELLO AGAIN!',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                  fontFamily: 'GeologicaBold'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Welcome back, you've been missed",
                              style: TextStyle(
                                  color: firthColor,
                                  wordSpacing: 3,
                                  letterSpacing: 1.2),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 30),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 3),
                              decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: email_input,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    icon: Icon(Icons.email_outlined),
                                    border: InputBorder.none,
                                    focusColor: Colors.grey,
                                    errorText:
                                        email_error == 'Done' ? null : email_error),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 30),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 3),
                              decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: password_input,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    icon: Icon(Icons.password),
                                    border: InputBorder.none,
                                    focusColor: Colors.grey,
                                    errorText: password_error == 'Done'
                                        ? null
                                        : password_error
                                        ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 250,
                              child: ElevatedButton(
                                onPressed: () async {
                                  String email=email_input.text.trim();
                                  String password=password_input.text.trim();
                                  if (email_input.text.trim().isNotEmpty &&
                                      password_input.text.trim().isNotEmpty) {
                                      setState(() {
                                        loding = true;
                                        email_input.text=email;
                                        password_input.text=password;
                                      });
                                      try{ await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: email_input.text.trim(),
                                              password: password_input.text.trim());
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        loding = false;
                                        email_input.text=email;
                                        password_input.text=password;
                                        if (e.message
                                            .toString()
                                            .toLowerCase()
                                            .contains('email')) {
                                          email_error = e.message.toString();
                                          password_error = 'Done';
                                        }else {
                                          if (e.message
                                              .toString()
                                              .toLowerCase()
                                              .contains('password')) {
                                            password_error = e.message.toString();
                                            email_error = 'Done';
                                          } else {
                                            email_error = e.message.toString();
                                            password_error = e.message.toString();
                                          }
                                        }
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  child: Container(
                                    child: loding == false
                                        ? Text(
                                            'SignIn',
                                            style: TextStyle(
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: thirdColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 12)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Not a mumber?',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      widget.updateFuction(RegisterPage(updateFuction: widget.updateFuction,));
                                    },
                                    child: Text(
                                      'Register Now',
                                      style: TextStyle(
                                          fontSize: 11, fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
