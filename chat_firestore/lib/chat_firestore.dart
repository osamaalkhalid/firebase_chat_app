library chat_firestore;
import 'details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class chat extends StatelessWidget{
   chat(this.name, this.Textend,this.time, this.green,this.email,this.auth);
  final String name;
  final String Textend;
  final String time;
  final bool green;
   late String email;
   late String auth;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  details(name, Textend, time, green,email,auth)),
      );
    },
      child: Container(
        margin: EdgeInsets.all(20),

        child: Column(
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

             Row(

               children: [
                 Stack(
                   children: [


                     Container(
                       height: 70,
                       width: 70,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         image: DecorationImage(
                           image: NetworkImage("http://cdn.onlinewebfonts.com/svg/img_237553.png"),

                           fit: BoxFit.cover,
                         ),
                       ),
                     ),



                     Container(
                       padding: EdgeInsets.all(4),
                       height: 22,
                       width:22,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color:Colors.white,
                       ),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: HexColor("#0EE3AA"),
                         ),

                       ),
                     ),




                   ],
                 ),

                 SizedBox(width: 20,),

                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Container(

                       child: Text(name,style:  GoogleFonts.signikaNegative(color:HexColor("#45464A"),fontWeight: FontWeight.w700,fontSize: 20),),
                     ),


                     Container(
                       child: Text(Textend,style: GoogleFonts.signikaNegative(color: HexColor("#45464A"),fontWeight: FontWeight.w400,fontSize: 18),),
                     ),


                   ],
                 ),

               ],
             ),


                Container(

                  child: Text(time,style: GoogleFonts.signikaNegative(color:HexColor("#37393e"),fontWeight: FontWeight.w600,fontSize: 15),),
                ),

              ],

            ),


          ],
        ),
      ),
    );
  }




}

class view extends StatefulWidget {

  final String auth;
  view(this.auth);

  @override
  State<view> createState() => _view();

}

class _view extends State<view> {


  late List contacts;
  @override
  Widget build(BuildContext context) {






      FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.auth)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          setState(() {
            contacts =  element["contacts"];

          });

            });
  });


late String email;



    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').where("email",whereIn: contacts).snapshots();


    return Column(

      children: [
        StreamBuilder<QuerySnapshot>(

          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


            return ListView(
              shrinkWrap: true,




              children: snapshot.data!.docs.map((DocumentSnapshot document) {

                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                int arrayLength=data['messag'].length;

                DateTime now =  data["messag"][arrayLength-1]["date"].toDate();
                String formattedTime = DateFormat.jms().format(now);


                return Column(

                  children: [
                    chat(data["name"], data["messag"][arrayLength-1]["msj"],
                        formattedTime,
                        true,data["email"],widget.auth),
                  ],
                );
              }).toList(),
            );
          },
        ),



        Container(


          height: 50.0,
          margin: EdgeInsets.all(10),
          child: RaisedButton(
            onPressed: () {

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title:   Text('Add New Contant',style:
                  GoogleFonts.poppins(color: HexColor("#45464A"),fontWeight: FontWeight.w700,fontSize: 20),),

                  content:  Container(

                    decoration: BoxDecoration(

                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:  EdgeInsets.only(left: 25, right: 20),
                    margin:  EdgeInsets.fromLTRB(20,10,20,10),
                    child: TextField(
                      onChanged: (value){
                         email = value;
                      },
                      style:  GoogleFonts.poppins(color: HexColor("#45464A"),fontWeight: FontWeight.w700,fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),


                  actions: <Widget>[

                    Container(
                      height: 40.0,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  HexColor("#e67a8e"),
                                  HexColor("#ffc6ad"),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            alignment:  Alignment.center,
                            constraints:
                            BoxConstraints(maxWidth: 100.0, minHeight: 20.0),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text('Cancel',style:
                                GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize:20),),

                              ],
                            ),

                          ),
                        ),
                      ),
                    ),


                    Container(


                      height: 40.0,

                      child: RaisedButton(
                        onPressed: () async{

                      try{
                        late String Docid;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .where('email', isEqualTo: widget.auth)
                            .get()
                            .then((value) {
                          value.docs.forEach((element) {

                            Docid = element.id;


                          });
                        });


                        FirebaseFirestore.instance.collection("users").doc(Docid).update({
                          'contacts': FieldValue.arrayUnion([email]),
                        });

                        Navigator.of(ctx).pop();
                      }catch(e){

                      }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  HexColor("#d62949"),
                                  HexColor("#ff824d"),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            alignment:  Alignment.center,
                            constraints:
                            BoxConstraints(maxWidth: 100.0, minHeight: 20.0),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text('add',style:
                                GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize:20),),

                              ],
                            ),

                          ),
                        ),
                      ),
                    ),




                  ],
                ),
              );

            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor("#DF5A72"),
                      HexColor("#FFAE8B"),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(

                constraints:
                BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add,color: Colors.white,size: 30,),
                    SizedBox(width: 4,),
                    Text('New Chat',style:
                    GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 30),),

                  ],
                ),

              ),
            ),
          ),
        ),

      ],
    );
  }

}


  
