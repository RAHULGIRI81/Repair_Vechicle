import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Mechanic_navigation.dart';
import 'Mechanic_signup.dart';


class Mechanic_login extends StatefulWidget {
  const Mechanic_login({super.key});

  @override
  State<Mechanic_login> createState() => _Mechanic_loginState();
}

class _Mechanic_loginState extends State<Mechanic_login> {
  var Email_ctrl=TextEditingController();
  var Password_ctrl=TextEditingController();
  String id= "";

  void Mechanic_login() async {
    final user = await FirebaseFirestore.instance
        .collection('Mechanic_signup_details')
        .where('Email', isEqualTo: Email_ctrl.text)
        .where('Password', isEqualTo: Password_ctrl.text).where('State',isEqualTo: 1)
        .get();
    if (user.docs.isNotEmpty) {
      id = user.docs[0].id;


      SharedPreferences data = await SharedPreferences.getInstance();
      data.setString('Mech_id', id);


      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Mechanic_navigation();
        },
      ));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.white,
          content: Center(
            child: Text(
              "Email And Password Error",
              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
            ),
          )));
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/tow1.png"))),
                    ),
                  ),
                  Center(
                      child: Text(
                        'MECH LOGIN',
                        style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w900),
                      ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Enter Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
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
                      decoration: InputDecoration(
                          hintText: 'Email',
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
                height: 30.h,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Enter Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
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
                      decoration: InputDecoration(
                          hintText: 'Enter Passsword',
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: Text(
                      "Forgot password ?",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () {
                    Mechanic_login();
                  },
                  child: Container(
                    height: 50.h,
                    width: 220.w,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have account ?",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Mechanic_signup();
                      },));
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
