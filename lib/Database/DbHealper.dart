import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Models/Arduino.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/UserClass.dart';

UserClass? user=null;
String selectedArduinoID='';
List<dynamic> arduinosList=[];

//create user information document
Future setUser(String fullName,String birthday, String email, String password) async{
  await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).set({
    'birthday':birthday,
    'email':email,
    'fullName':fullName,
    'password':password,
    'id':FirebaseAuth.instance.currentUser!.uid.toString()
});
}

//get user information from Db
UserClass getUserInformation(QuerySnapshot snapshot){
  var doc=snapshot.docs[0];
  return UserClass(
    id: doc.get('id'),
    fullName: doc.get('fullName'),
    birthday: doc.get('birthday'),
    email: doc.get('email'),
    password: doc.get('password'),
    arduinos: doc.get('arduinos')
    );
}


List<Arduino> snapshotTOAruinosList(QuerySnapshot snapshot){
  List<Arduino> list=[];
  for(var doc in snapshot.docs){
    list.add(
      Arduino(
        id: doc.get("id"),
        name: doc.get("name"),
        humidity:double.parse( doc.get("humidity").toStringAsFixed(1)),
        luminosity: double.parse( doc.get("luminosity").toStringAsFixed(1)),
        groundHumidity:double.parse( doc.get("groundHumidity").toStringAsFixed(1)),
        temperature: double.parse( doc.get("temperature").toStringAsFixed(1)),
        desiredTemperature: double.parse( doc.get("desiredTemperature").toStringAsFixed(1)),
        desiredGroundHumidity: double.parse( doc.get("desiredGroundHumidity").toStringAsFixed(1)),
        light: double.parse( doc.get("light").toStringAsFixed(1))
        )
    );
  }
  return list;
}

void updateArduino(String field,var value,String id){
  FirebaseFirestore.instance.collection('Arduinos').doc(id).update({field: value});
}

void updateArduinosList(List<dynamic> idsList){
  FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({'arduinos':idsList});
}

//stream user information
Stream<QuerySnapshot?> get streamUser{
  return FirebaseFirestore.instance.collection('Users').where("id", isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots();
}

//stream current user
Stream<User?> get currentUser{
  return FirebaseAuth.instance.authStateChanges();
}

//stream Arduinos
Stream<QuerySnapshot?> get streamArduinos{
  return FirebaseFirestore.instance.collection('Arduinos').snapshots();
}

Stream<QuerySnapshot?> get streamMYArduinos{
  return FirebaseFirestore.instance.collection('Arduinos').where('id',whereIn: arduinosList+['°']).snapshots();
}

//stream Arduinos Details
Stream<QuerySnapshot?> get streamArduinosDrtails{
  return FirebaseFirestore.instance.collection('Arduinos').where("id",isEqualTo: selectedArduinoID).snapshots();
}