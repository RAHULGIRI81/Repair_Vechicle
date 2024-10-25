import 'package:repair_vechicle/Admin/Notification.dart';
import 'package:repair_vechicle/Admin/Vehicle_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Mechanic_page extends StatefulWidget {
  const Mechanic_page({super.key, required this.id});
  final id;

  @override
  State<Mechanic_page> createState() => _Mechanic_pageState();
}

class _Mechanic_pageState extends State<Mechanic_page> {


  Future<void> _acceptStatus() async {
    await FirebaseFirestore.instance
        .collection('Mechanic_signup_details')
        .doc(widget.id)
        .update({'State': 1});
    Navigator.pop(context);
  }

  Future<void> _rejectStatus() async {
    await FirebaseFirestore.instance
        .collection('Mechanic_signup_details')
        .doc(widget.id)
        .update({'State': 2});
    Navigator.pop(context);
  }



  Future<void> Getbyid() async {
    Mech = await FirebaseFirestore.instance
        .collection("Mechanic_signup_details")
        .doc(widget.id)
        .get();
  }

  DocumentSnapshot? Mech;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getbyid(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          LinearProgressIndicator();
        }
        if(snapshot.hasError){
          Text('Error: ${snapshot.error}');
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.blue.shade100,
          ),
          backgroundColor: Colors.blue[100],
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  height: 850,
                  width: 500,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white),
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
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image:
                                      NetworkImage('${Mech?["Profile"]}'),
                                      fit: BoxFit.cover)),
                            ),
                            Center(
                                child: Text(
                                  '${Mech?["Name"]}',
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                )),
                            Center(
                                child: Text(
                                  '${Mech?["Location"]}',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Column(
                          children: [
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
                                        hintText: '${Mech?["Name"]}',
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
                              height: 5,
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
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        hintText: '${Mech?["Number"]}',
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
                              height: 5,
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
                                        hintText: '${Mech?["Email"]}',
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
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Work Experience',
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
                                        hintText: '${Mech?["Experience"]}',
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
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Work Shop Name',
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
                                        hintText: '${Mech?["Shop_name"]}',
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
                              height: 5,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Your Location',
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
                                        hintText: '${Mech?["Location"]}',
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
