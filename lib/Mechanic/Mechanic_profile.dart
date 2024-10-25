import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Mechanic_navigation.dart';
import 'Mechanic_profile_edit.dart';

class Mechanic_profile extends StatefulWidget {
  const Mechanic_profile({super.key});

  @override
  State<Mechanic_profile> createState() => _Mechanic_profileState();
}

class _Mechanic_profileState extends State<Mechanic_profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_data_sp();
  }

  var id;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      id = data.getString("Mech_id");

      print("Get Successful//////////////////");
      print(id);
    });
  }

  Future<void> Getbyid() async {
    Profile = await FirebaseFirestore.instance
        .collection("Mechanic_signup_details")
        .doc(id)
        .get();
  }

  DocumentSnapshot? Profile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getbyid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.blue,
          );
        }
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) {
                                return Mechanic_navigation();
                              },
                            ));
                          },
                          icon: Icon(
                            CupertinoIcons.back,
                            color: Colors.black,
                            size: 35.sp,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return Mechanic_profile_edit();
                              },
                            ));
                          },
                          icon: Icon(
                            Icons.edit_note,
                            color: Colors.black,
                            size: 35.sp,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: NetworkImage(Profile!["Profile"]),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: Profile!["Name"],
                                      focusColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      fillColor: Colors.blue.shade50,
                                      filled: true),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: Profile!["Number"],
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  fillColor: Colors.blue.shade50,
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: Profile!["Email"],
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  fillColor: Colors.blue.shade50,
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: Profile!["Experience"],
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  fillColor: Colors.blue.shade50,
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: Profile!["Location"],
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  fillColor: Colors.blue.shade50,
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: Profile!["Shop_name"],
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  fillColor: Colors.blue.shade50,
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return Mechanic_navigation();
                              },
                            ));
                          },
                          child: Container(
                            height: 50.h,
                            width: 220.w,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                                child: Text(
                              'DONE',
                              style: TextStyle(
                                  fontSize: 18.sp,
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
        );
      },
    );
  }
}
