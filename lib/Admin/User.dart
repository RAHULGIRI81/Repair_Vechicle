
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class User_page extends StatefulWidget {
  const User_page({super.key, required this.id});
  final id;

  @override
  State<User_page> createState() => _User_pageState();
}

class _User_pageState extends State<User_page> {


  Future<void> _acceptStatus() async {
    await FirebaseFirestore.instance
        .collection('User_signup_details')
        .doc(widget.id)
        .update({'State': 1});
    Navigator.of(context).pop();
  }

  Future<void> _rejectStatus() async {
    await FirebaseFirestore.instance
        .collection('User_signup_details')
        .doc(widget.id)
        .update({'State': 2});
    Navigator.of(context).pop();
  }




  Future<void> Getbyid() async {
    User = await FirebaseFirestore.instance
        .collection("User_signup_details")
        .doc(widget.id)
        .get();
  }

  DocumentSnapshot? User;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Getbyid(),
       builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        LinearProgressIndicator();
      }
      if(snapshot.hasError){
        Text('Error: ${snapshot.error}');
      }
         return Scaffold(
           backgroundColor: Colors.blue[100],
           body: Padding(
             padding: const EdgeInsets.only(right: 20, left: 20),
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.only(top: 80),
                 child: Container(
                   height: 810,
                   width: 500,
                   decoration: BoxDecoration(color: Colors.white),
                   child: Padding(
                     padding: const EdgeInsets.only(
                       right: 20,
                       left: 20,
                       top: 20
                     ),
                     child: Column(
                       children: [

                         Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 10),
                               child: Container(
                                 width: 150,
                                 height: 150,
                                 decoration: BoxDecoration(
                                     color: Colors.blue.shade50,
                                     borderRadius: BorderRadius.circular(100),
                                     image: DecorationImage(
                                         image:
                                         NetworkImage("${User?["Profile"]}"),
                                         fit: BoxFit.cover)),
                               ),
                             ),
                             SizedBox(
                               height: 5,
                             ),
                             Center(
                                 child: Text(
                                   '${User?["Name"]}',
                                   style: TextStyle(
                                       fontSize: 30, fontWeight: FontWeight.bold),
                                 )),
                             SizedBox(
                               height: 5,
                             ),
                             Center(
                                 child: Text(
                                   '${User?["Location"]}',
                                   style: TextStyle(
                                       fontSize: 20, fontWeight: FontWeight.bold),
                                 ))
                           ],
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         Column(
                           children: [
                             Row(
                               children: [
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Text(
                                   'Username',
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold, fontSize: 18),
                                 ),
                               ],
                             ),
                             SizedBox(
                               height: 3,
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 10, right: 10),
                               child: TextFormField(
                                 readOnly: true,
                                 decoration: InputDecoration(
                                     hintText: '${User?["Location"]}',
                                     focusColor: Colors.white,
                                     filled: true,
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(10),
                                         borderSide: BorderSide(
                                             style: BorderStyle.none,
                                             color: Colors.white))),
                               ),
                             )
                           ],
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Column(
                           children: [
                             Row(
                               children: [
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Text(
                                   'Phone Number',
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold, fontSize: 18),
                                 ),
                               ],
                             ),
                             SizedBox(
                               height: 3,
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 10, right: 10),
                               child: TextFormField(
                                 decoration: InputDecoration(
                                     hintText: '${User?["Number"]}',
                                     focusColor: Colors.white,
                                     filled: true,
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(10),
                                         borderSide:
                                         BorderSide(color: Colors.black))),
                               ),
                             )
                           ],
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Column(
                           children: [
                             Row(
                               children: [
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Text(
                                   'Email Address',
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold, fontSize: 18),
                                 ),
                               ],
                             ),
                             SizedBox(
                               height: 3,
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 10, right: 10),
                               child: TextFormField(
                                 readOnly: true,
                                 decoration: InputDecoration(
                                     hintText: '${User?["Email"]}',
                                     focusColor: Colors.white,
                                     filled: true,
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(10),
                                         borderSide:
                                         BorderSide(color: Colors.black))),
                               ),
                             )
                           ],
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 20, top: 50),
                           child: Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(top: 10),
                                 child: InkWell(
                                   onTap: () {
                                     _acceptStatus();
                                   },
                                   child: Container(
                                     height: 50,
                                     width: 130,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(6),
                                       color: Colors.blue.shade500,
                                     ),
                                     child: Center(
                                         child: Text(
                                           'Accept',
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white),
                                         )),
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 45,
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 10),
                                 child: InkWell(
                                   onTap: () {
                                     _rejectStatus();
                                   },
                                   child: Container(
                                     height: 50,
                                     width: 130,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(6),
                                       color: Colors.red.shade500,
                                     ),
                                     child: Center(
                                         child: Text(
                                           'reject',
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white),
                                         )),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 30,
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           ),
         );
       },

    );
  }
}