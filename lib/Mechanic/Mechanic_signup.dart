import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Mechanic_login.dart';

class Mechanic_signup extends StatefulWidget {
  const Mechanic_signup({super.key});

  @override
  State<Mechanic_signup> createState() => _Mechanic_signupState();
}

class _Mechanic_signupState extends State<Mechanic_signup> {
  var Name_ctrl = TextEditingController();
  var Number_ctrl = TextEditingController();
  var Email_ctrl = TextEditingController();
  var Experience_ctrl = TextEditingController();
  var Shop_name_ctrl = TextEditingController();
  var Location_ctrl = TextEditingController();
  var Password_ctrl = TextEditingController();

  Future<void> Mechanic_signup() async {
    FirebaseFirestore.instance.collection("Mechanic_signup_details").add({
      "Profile":
          "https://cdn.pixabay.com/photo/2020/07/08/14/29/mechanic-5384089_1280.png",
      "Name": Name_ctrl.text,
      "Number": Number_ctrl.text,
      "Email": Email_ctrl.text,
      "Experience": Experience_ctrl.text,
      "Shop_name": Shop_name_ctrl.text,
      "Location": Location_ctrl.text,
      "Password": Password_ctrl.text,
      "State": 0,
    });
    if (formkey.currentState!.validate()) {


    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return
          Mechanic_login();
      },
    ));
    }
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Mechanic_login();
                          },
                        ));
                      },
                      icon: Icon(
                        CupertinoIcons.back,
                        color: Colors.black,
                        size: 35.sp,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      width: 200.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/tow1.png"))),
                    ),
                    Center(
                        child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w900),
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Name_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Username',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter Phone number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Number_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Phone number',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter your email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Email_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter email',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter your Work Experience',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Experience_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your Experience',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter your Work Shop Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Shop_name_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your Shop Name',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter your Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Location_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your Locatiom',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Enter your password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: Password_ctrl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Any Value";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your password',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(0)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Mechanic_signup();
                        },
                        child: Container(
                          height: 50.h,
                          width: 220.w,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                              child: Text(
                            'SIGN UP',
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
            ),
          ],
        ),
      ),
    );
  }
}
