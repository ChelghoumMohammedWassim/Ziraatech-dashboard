import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Const.dart';
import 'package:dashboard/Database/DbHealper.dart';
import 'package:dashboard/Models/UserClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {

    QuerySnapshot? value=Provider.of(context);

    UserClass? user=null;
    late  String formattedDate;

    if(value!=null){
      user=getUserInformation(value);
      formattedDate= DateFormat.yMMMEd().format(DateTime.parse(user.birthday));
    }


    return user==null? Container(
      child: Center(
        child: SpinKitThreeBounce(
                      color: primaryColor,
                      size: 40.0,
                    ),
      ),
    )
    :Container(
      padding: EdgeInsets.only(top: 20),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: bgColor,
            elevation: 4,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset("images/logo.png",height: 40,),
                            const SizedBox(width: 7,),
                            const Text("ziraatech",style: TextStyle(fontWeight: FontWeight.w800,letterSpacing: 1.5),)
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.logout_outlined),
                          iconSize: 28,
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("images/farmer.png",height: 80,),
                        SizedBox(width: 13,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome",style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.7)),),
                            Text(user.fullName,style: TextStyle(fontSize: 20, color: thirdColor,fontWeight: FontWeight.w600),),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 550,
            backgroundColor: Colors.transparent,
            bottom: const PreferredSize(
              child: SizedBox(),
               preferredSize: Size.fromHeight(-10)),
            flexibleSpace:Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent.withOpacity(0.3),
                              radius: 25,
                              child: Icon(
                                Icons.person_2_outlined,
                                color: Colors.blueAccent[700],
                                ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Full Name",style: TextStyle(fontSize: 17),),
                                SizedBox(height: 2,),
                                Text(user.fullName)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),SizedBox(height: 20,),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green.withOpacity(0.3),
                              radius: 25,
                              child: ImageIcon(
                                AssetImage("images/dateofbirth.png"),
                                color: Colors.green[700],
                                ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Birthday",style: TextStyle(fontSize: 17),),
                                SizedBox(height: 2,),
                                Text(formattedDate)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),SizedBox(height: 20,),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.purple.withOpacity(0.3),
                              radius: 25,
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.purple[700],
                                ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Email",style: TextStyle(fontSize: 17),),
                                SizedBox(height: 2,),
                                Text(user.email)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),SizedBox(height: 20,),

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber.withOpacity(0.3),
                              radius: 25,
                              child: Icon(
                                Icons.password_rounded,
                                color: Colors.amber[700],
                                ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Password",style: TextStyle(fontSize: 17),),
                                SizedBox(height: 2,),
                                Text("*"*user.password.length,style: TextStyle(),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),SizedBox(height: 20,),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}