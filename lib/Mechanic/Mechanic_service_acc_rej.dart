import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Mechanic_navigation.dart';

class Mechanic_service_acc_rej extends StatefulWidget {
  const Mechanic_service_acc_rej(
      {super.key,
        required this.User_id,
        required this.User_problem,
        required this.User_place,
        required this.User_phn,
        required this.Date,
        required this.Time,
        required this.User_name});
  final User_id;
  final User_problem;
  final User_place;
  final User_phn;
  final Date;
  final Time;
  final User_name;

  @override
  State<Mechanic_service_acc_rej> createState() =>
      _Mechanic_service_acc_rejState();
}

class _Mechanic_service_acc_rejState extends State<Mechanic_service_acc_rej> {

  Future<void> _acceptStatus() async {
    await FirebaseFirestore.instance
        .collection('User_request')
        .doc(widget.User_id)
        .update({'Mech_status': 1});
    Navigator.pop(context);
  }

  Future<void> _rejectStatus() async {
    await FirebaseFirestore.instance
        .collection('User_request')
        .doc(widget.User_id)
        .update({'Mech_status': 2});
    Navigator.pop(context);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Card(
                child: Container(
                  height: 500.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.blue.shade100),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 30, right: 20, top: 160),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Problem',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Place',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Date',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Time',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  'Contact number',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  ' : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  ' : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  ' : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  ' : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.User_problem,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  widget.User_place,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  widget.Date,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  widget.Time,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  widget.User_phn,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Container(
                                  width: 100.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10.r),
                                      color: Colors.green),
                                  child: Center(
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _acceptStatus();
                                },
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              InkWell(
                                onTap: () {
                                  _rejectStatus();
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 133.w),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50.r,
                    backgroundImage: AssetImage('assets/person1.png'),
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    widget.User_name,
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
