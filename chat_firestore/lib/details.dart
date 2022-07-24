library chat_firestore;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class details extends StatelessWidget{
  details(this.name, this.Textend,this.time, this.green,this.sender,this.authh);
  final String name;
  final String Textend;
  final String time;
  final bool green;
  final String sender;
  late String msj;
  late String authh;




    @override
  Widget build(BuildContext context) {


      CollectionReference users = FirebaseFirestore.instance.collection('users');
      final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').where("email", isEqualTo:authh).snapshots();

    // TODO: implement build
    return Scaffold(


        appBar:  AppBar(


          automaticallyImplyLeading: false,
          elevation: 1,
          toolbarHeight: 70,
          backgroundColor: HexColor("#DF5A72"),
        leading: IconButton(onPressed: () {

          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color:Colors.black54)),
          actions: <Widget>
          [

            Row(

              children: [



                Text(name,style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w500,fontSize: 30),),

                Container(


                  child:   IconButton(onPressed: null, icon: Icon(Icons.phone,color:Colors.white,size: 30,)),

                ),
                Container(


                  child:   IconButton(onPressed: null, icon: Icon(Icons.more_vert_outlined,color:Colors.white,size: 30,)),

                ),
              ],
            )

          ]
      ),

      body:SingleChildScrollView(
        child:Column(



        children: [

          Container(
            
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListView(

              padding: EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              children: [

                           StreamBuilder<QuerySnapshot>(
                           stream: _usersStream,
                           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                             if (snapshot.hasError) {
                               return Text('Something went wrong');
                             }

                             if (snapshot.connectionState == ConnectionState.waiting) {
                               return Text("Loading");
                             }

                             return Column(




                               children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                 Map<String, dynamic> data = document.data()! as Map<String, dynamic>;



                                 int arrayLength=data['messag'].length-1;

                                 return contion(data['messag'].reversed.toList(),arrayLength,"to"+sender);

                               }).toList(),
                             );
                           },
                         ),








              ],

            ),
          ),

            Container(
                  decoration: BoxDecoration(
                    color: HexColor("#F6F7F9"),

                  ),
                   child: TextFormField(

                     onChanged: (value){
                       msj = value;
                     },

                      style: GoogleFonts.poppins(color:HexColor("#6F757C"),fontWeight: FontWeight.w500,fontSize: 20),
                     decoration: InputDecoration(

                         hintText: 'write your message here...',
                         hintStyle: GoogleFonts.poppins(color:HexColor("#696E7E"),fontWeight: FontWeight.w500,fontSize: 20),
                         border: OutlineInputBorder(
                           borderSide:  BorderSide(color: Colors.transparent, width: 0.0),

                         ),
                         enabledBorder: OutlineInputBorder(
                           borderSide:  BorderSide(color: Colors.transparent, width: 0.0),

                         ),
                         focusedBorder:OutlineInputBorder(
                           borderSide:  BorderSide(color: Colors.transparent, width: 0.0),

                         ),

                         filled: true,
                         prefixIcon:IconButton(
                             icon: Icon(Icons.add_rounded,color:HexColor("#696E7E"),size: 30,),
                             onPressed: () {
                               debugPrint('222');
                             }),
                         suffixIcon: IconButton(
                             icon: Icon(Icons.send_rounded,color:HexColor("#DF5A72"),),
                             onPressed: () {
                               addMsj();
                             })),
                   ),
                 ),





        ],
      ),


),
    );

  }


    void addMsj() async{




      late String Docid;
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: sender)
          .get()
          .then((value) {
        value.docs.forEach((element) {

          Docid = element.id;


        });
      });
print(sender);

      var map = new Map<String, dynamic>();
      map['msj'] = msj;
      map['sender'] = sender ;
      map['date'] = DateTime.now() ;

      FirebaseFirestore.instance.
      collection('users').
      doc(Docid).set({
        "messag": FieldValue.arrayUnion(
          [map],
        ),

      },SetOptions(merge: true)

      ).catchError((e) {
        print(e);
      });



      late String Docid2;
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: authh)
          .get()
          .then((value) {
        value.docs.forEach((element) {

          Docid2 = element.id;


        });
      });

      var map2 = new Map<String, dynamic>();
      map2['msj'] = msj;
      map2['date'] = DateTime.now() ;
      map2['email'] = "to"+sender;
      FirebaseFirestore.instance.
      collection('users').
      doc(Docid2).set({
        "messag": FieldValue.arrayUnion(
          [map2],
        ),

      },SetOptions(merge: true)

      ).catchError((e) { print(e); });



    }


}

class contion extends StatelessWidget {
  contion(this.themsj,this.linth,this.fat);

  late var themsj;
  late int linth;
  late String fat;


  @override
  Widget build(BuildContext context) {
    print(fat);
    final ScrollController _scrollController = ScrollController();


    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
return Container(
  height: 580,
  width: 800,
  child: ListView(
    shrinkWrap: true,
    controller: _scrollController,
    reverse: true,



    scrollDirection: Axis.vertical,
    children: [

      for(var i = 0;i<=linth;i++)

        themsj[i]["email"] == fat ?
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [mychat(themsj[i]["msj"])], )
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [userchat(themsj[i]["msj"])], ),

    ],
  ),
);




  }

}


class userchat extends StatelessWidget{
  userchat(this.message,);

  late String message;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,

     children: [
       Container(

         padding: EdgeInsets.all(10),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.only(
               topLeft: Radius.circular(10),
               topRight: Radius.circular(10),
               //  bottomLeft: Radius.circular(10),
               bottomRight: Radius.circular(10)
           ),
           color: Colors.white,
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 2,
               blurRadius: 7,
               offset: Offset(0, 8), // changes position of shadow
             ),
           ],
         ),

         child:Text(message,style: GoogleFonts.poppins(color:HexColor("#15171A"),fontWeight: FontWeight.w400,fontSize: 18),),

       ),
       SizedBox(height: 10,),
     ],
   );
  }

}


class mychat extends StatelessWidget{
  mychat(this.mymessage);
  late String mymessage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(

          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              //bottomRight: Radius.circular(10)
            ),
            color:HexColor("#DF5A72"),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 8), // changes position of shadow
              ),
            ],
          ),

          child:Text(mymessage,style: GoogleFonts.poppins(color:Colors.white,fontWeight: FontWeight.w400,fontSize: 18),),

        ),
        SizedBox(height: 10,)
      ],
    );
  }

}