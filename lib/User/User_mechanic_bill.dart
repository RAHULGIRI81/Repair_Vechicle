import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Payment_successful.dart';
import 'User_rating.dart';

class User_mechanic_bill extends StatefulWidget {
  const User_mechanic_bill({super.key, required this.id, required this.Amount, required this.Name, required this.Experiance, /*required this.Profile*/});
  final id;
  final Amount;
  final Name;
  final Experiance;
  /*final Profile;*/
  @override
  State<User_mechanic_bill> createState() => _User_mechanic_billState();
}

class _User_mechanic_billState extends State<User_mechanic_bill> {

  Future<void> Pay() async {
    FirebaseFirestore.instance
        .collection("User_request")
        .doc(widget.id)
        .update({ 'Payment': 5});
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Payment_successful();
      },
    ));
  }

  var Bill_amount=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: Text(
            "Mechanic Bill",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.sp),
          ),
          toolbarHeight: 60.h,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
               /* Container(
                  height: 120.h,
                  width: 120.w,
                  child: Image(
                    image: NetworkImage(widget.Profile),
                    fit: BoxFit.fill,
                  ),
                ),*/
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  widget.Name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "${widget.Experiance} Of Experiance",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 40.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Center(
                    child: Text(
                      "Available",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 28.sp,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 28.sp,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 28.sp,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 28.sp,
                    ),
                    Icon(
                      Icons.star_half,
                      color: Colors.yellow.shade700,
                      size: 28.sp,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return User_rating();
                        },));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 70.h,
                ),
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
                    readOnly: true,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.currency_rupee),
                        hintText: widget.Amount.toString(),
                        prefix: Padding(
                          padding: const EdgeInsets.only(top: 10),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900
                        ),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                InkWell(
                  onTap: () {
                    Pay();
                  },
                  child: Container(
                    height: 60.h,
                    width: 230.w,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                        child: Text(
                          'Pay',
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
        ));
  }
}
