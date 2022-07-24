# Firebase Chat App
 

[![N|Solid](https://firebase.google.com/static/downloads/brand-guidelines/SVG/logo-built_white.svg)](https://firebase.google.com/static/downloads/brand-guidelines/SVG/logo-built_white.svg)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](http://afak.epizy.com/)

Receive your messages from your customers quickly and live

- Flutter
- Firevase
- ✨Afak Technology ✨

## Features

- Send and receive messages
- Use of firebase
- Add specific contacts
- Send messages live and directly
 ## Code Us
first you have to download this packages to start use our package
-   flutter_lints: ^2.0.0
-  google_fonts: ^3.0.1
-  hexcolor: ^2.0.7
-  firebase_auth: ^3.4.2
-  cloud_firestore: ^3.3.0
-  firebase_core: ^1.19.2
 
 
```dart 

import 'package:flutter/material.dart';
import 'package:chat_firestore/chat_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());

}

class MyApp extends StatelessWidget {


  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FirebaseChat',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FirebaseChat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: Column(

             children: [
              //AppBar widget
               Container(

                 width: 500,
                height: 110,
                  alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(top: 25,bottom: 1,right: 10,left: 10),
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                       colors: [
                         HexColor("#DF5A72"),
                         HexColor("#FFAE8B"),
                       ],
                       begin:  FractionalOffset(0.0, 0.0),
                       end:  FractionalOffset(1.0, 0.0),
                       stops: [0.0, 1.0],
                       tileMode: TileMode.clamp),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                       spreadRadius: 0.5,
                       blurRadius: 7,
                       offset: Offset(0, 3), // changes position of shadow
                     ),
                   ],

                   borderRadius: BorderRadius.circular(0),
                 ),

                 child: Text('Chats',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 40),),

               ),


               //Your Signedin Email
               view("osama@gmail.com"),

             ],
           ),



     );
  }
}

```
## Firbase Firestore Data Base
![image](https://user-images.githubusercontent.com/86790667/180660501-76c18a47-d7cc-4e49-bb9e-b8e4a2503aff.png)
![image](https://user-images.githubusercontent.com/86790667/180660509-db53f826-3275-4946-ba72-b07a94ff7678.png)


