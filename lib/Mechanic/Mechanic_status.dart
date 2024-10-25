import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Mechanic_navigation.dart';

class Mechanic_status extends StatefulWidget {
  const Mechanic_status(
      {super.key,
        required this.id,
        required this.Work,
        required this.Name,
        required this.Date,
        required this.Time,
        required this.Profile});
  final id;
  final Work;
  final Name;
  final Date;
  final Time;
  final Profile;

  @override
  State<Mechanic_status> createState() => _Mechanic_statusState();
}

class _Mechanic_statusState extends State<Mechanic_status> {
  var Amount_ctrl = TextEditingController();
  Future<void> Amount_add() async {
    FirebaseFirestore.instance
        .collection("User_request")
        .doc(widget.id)
        .update({'Amount': Amount_ctrl.text, 'Payment': 3});
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Mechanic_navigation();
      },
    ));
  }


  var Reject_res_ctrl = TextEditingController();
  Future<void> Reject_reason() async {
    FirebaseFirestore.instance
        .collection("User_request")
        .doc(widget.id)
        .update({'Reject_reason': Reject_res_ctrl.text, 'Payment': 4});
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Mechanic_navigation();
      },
    ));
  }

  String _status = 'Completed';

  @override
  Widget build(BuildContext context) {
    if (widget.Profile == null) {
      return Center(
        child:
        CircularProgressIndicator(), // Loading indicator while data is being fetched
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Card(
                    color: Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 90.w,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(widget.Profile),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(50.r)),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.Name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50.h,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.Work,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.Date,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.Time,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Place",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      "Add Status",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                activeColor: Colors.blue.shade900,
                                value: 'Completed',
                                groupValue: _status,
                                onChanged: (String? value) {
                                  setState(() {
                                    _status = value!;
                                  });
                                },
                              ),
                              Text('Completed',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(width: 20.w), // Space between containers
                          Row(
                            children: [
                              Radio<String>(
                                hoverColor: Colors.blue,
                                activeColor: Colors.blue.shade900,
                                value: 'Not Completed',
                                groupValue: _status,
                                onChanged: (String? value) {
                                  setState(() {
                                    _status = value!;
                                  });
                                },
                              ),
                              Text('Not Completed',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  child: _status == "Completed"
                      ? Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            "Amount",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Container(
                        height: 60.h,
                        width: 250.w,
                        child: TextFormField(
                          controller: Amount_ctrl,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.currency_rupee),
                              hintText: "amount",
                              prefix: Padding(
                                padding: const EdgeInsets.only(top: 10),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 15.sp,
                              ),
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      InkWell(
                        onTap: () {
                          Amount_add();
                        },
                        child: Container(
                          height: 60.h,
                          width: 230.w,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            "Reject Reason",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          child: TextFormField(
                            controller: Reject_res_ctrl,
                            minLines: 5,
                            maxLines: 10,
                            decoration: InputDecoration(
                                hintText: "Reject reason",
                                prefix: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                fillColor: Colors.white,
                                filled: true),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      InkWell(
                        onTap: () {
                          Reject_reason();
                        },
                        child: Container(
                          height: 60.h,
                          width: 230.w,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
