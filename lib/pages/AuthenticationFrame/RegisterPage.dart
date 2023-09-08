import 'package:dashboard/Const.dart';
import 'package:dashboard/pages/AuthenticationFrame/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../Database/DbHealper.dart';


class RegisterPage extends StatefulWidget {
  final Function updateFuction;
  RegisterPage({super.key,required this.updateFuction});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullName_input=TextEditingController();
  TextEditingController birthday_input=TextEditingController();
  TextEditingController email_input=TextEditingController();
  TextEditingController password_input=TextEditingController();
  TextEditingController password_confirmation_input=TextEditingController();
  
  late DateTime? selected_date;

  late String email_error;
  late String password_error;
  late String confirmation_password_error;
  late bool loding;

  late bool fullName_state;
  late bool email_state;
  late bool password_state;
  late bool confirmation_state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email_error='Done';
    confirmation_password_error='Done';
    password_error='Done';
    loding=false;
    fullName_state=true;
    email_state=true;
    password_state=true;
    confirmation_state=true;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text('CREATE YOUR ACCOUNT',style: TextStyle(color: primaryColor,fontSize: 28,fontFamily: 'Noto',fontWeight: FontWeight.w600),),
                    const SizedBox(
                      height: 15,
                    ),
                                
                    Text("And welcome to our Family(°-°)",style: TextStyle(color: firthColor,wordSpacing: 3,letterSpacing: 1.2),),
                    
                    const SizedBox(
                      height: 40,
                    ),
                           
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  TextField(
                        controller: fullName_input,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          border: InputBorder.none,
                          focusColor: Colors.grey,
                          enabled: fullName_state
                        ),
                      ),
                    ),
                                
                    const SizedBox(
                      height: 10,
                    ),
                           
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  GestureDetector(
                        child: TextField(
                          controller: birthday_input,
                          decoration: InputDecoration(
                            hintText: 'Birthday',
                            icon: Icon(Icons.date_range),
                            border: InputBorder.none,
                            focusColor: Colors.grey,
                            enabled: false
                          ),
                        ),
                        onTap: () async{
                          selected_date= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());
                          if(selected_date!=null){
                            setState(() {
                              final DateFormat formatter = DateFormat('yyyy-MM-dd');
                              birthday_input.text=formatter.format(selected_date!).toString();
                            });
                          }
                        },
                      ),
                    ),
                                
                    const SizedBox(
                      height: 10,
                    ),
                           
                           
                                
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  TextField(
                        controller: email_input,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          icon: Icon(Icons.email_outlined),
                          border: InputBorder.none,
                          focusColor: Colors.grey,
                          enabled: email_state,
                          errorText: email_error=='Done'? null : email_error
                        ),
                      ),
                    ),
                                
                    const SizedBox(
                      height: 10,
                    ),
                                
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:  TextField(
                        controller: password_input,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          icon: Icon(Icons.password),
                          border: InputBorder.none,
                          focusColor: Colors.grey,
                          enabled: password_state,
                          errorText: password_error=='Done'? null: password_error
                        ),
                      ),
                    ),
                                
                    const SizedBox(
                      height: 10,
                    ),
                                
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  TextField(
                        controller: password_confirmation_input,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          icon: Icon(Icons.password),
                          border: InputBorder.none,
                          focusColor: Colors.grey,
                          enabled: confirmation_state,
                          errorText: confirmation_password_error=='Done'? null : confirmation_password_error
                        ),
                      ),
                    ),
                                
                    const SizedBox(
                      height: 30,
                    ),
                                
                    
                    Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(fullName_input.text.trim().isNotEmpty && birthday_input.text.trim().isNotEmpty && email_input.text.trim().isNotEmpty && password_input.text.trim().isNotEmpty){
                            if(password_input.text.trim()==password_confirmation_input.text.trim()){
                                setState(() {
                                  loding=true;
                                  fullName_state=false;
                                  email_state=false;
                                  password_state=false;
                                  confirmation_state=false;
                                });
                                try{
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_input.text.trim(), password: password_input.text.trim());
                                setUser(fullName_input.text.trim(), selected_date.toString(), email_input.text.trim(), password_input.text.trim());
                                await FirebaseAuth.instance.signInWithEmailAndPassword(email: email_input.text.trim(), password: password_input.text.trim());
                              }on FirebaseAuthException catch(e){
                                  setState(() {
                                    loding=false;
                                    fullName_state=true;
                                    email_state=true;
                                    password_state=true;
                                    confirmation_state=true;
                                    if(e.message.toString().toLowerCase().contains('email')){
                                      email_error=e.message.toString();    
                                      password_error='Done'; 
                                      confirmation_password_error=password_error='Done';                              
                                    }else{
                                      if(e.message.toString().toLowerCase().contains('password')){
                                        password_error=e.message.toString();
                                        email_error='Done';      
                                        confirmation_password_error=password_error='Done';                                                      
                                      }else{
                                        email_error=e.message.toString();
                                        password_error=e.message.toString();
                                        confirmation_password_error=password_error='Done';                              
                                      }
                                    }
                                  });
                                }
                            }else{
                              setState(() {
                                confirmation_password_error='Conformation incorrect';
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: thirdColor,
                          padding: EdgeInsets.symmetric(horizontal: 80,vertical: 12)
                        ),
                         child: Container(
                          child: loding==false? Text('Register',style: TextStyle(letterSpacing: 1.5,fontWeight: FontWeight.bold),)
                          : const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                          ),
                        ),                                
                      ),
                    ),
                    
                    const SizedBox(
                      height: 20,
                    ),      
                                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('I have a account?', style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
                        TextButton(
                          onPressed: (){
                            widget.updateFuction(LoginPage(updateFuction: widget.updateFuction));
                          },
                           child: Text('Login now',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
                           )
                      ],
                    )   
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}