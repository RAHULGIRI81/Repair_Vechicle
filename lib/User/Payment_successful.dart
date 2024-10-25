import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


import 'User_mechanic_list.dart';

class Payment_successful extends StatefulWidget {
  const Payment_successful({super.key});

  @override
  State<Payment_successful> createState() => _Payment_successfulState();
}

class _Payment_successfulState extends State<Payment_successful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200.h,
                width: 200.w,
                child: Lottie.asset("assets/tick.json",
                    repeat: false, fit: BoxFit.fill)),
            SizedBox(height: 80.h,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return User_mechanic_list();
                },));
              },
              child: Container(
                height: 60.h,
                width: 300.w,
                decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                    child: Text(
                      'Back To Home Page',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
