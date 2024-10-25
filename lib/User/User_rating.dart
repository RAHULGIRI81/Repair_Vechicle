import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'User_mechanic_list.dart';


class User_rating extends StatefulWidget {
  const User_rating({super.key});

  @override
  State<User_rating> createState() => _User_ratingState();
}

class _User_ratingState extends State<User_rating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: Text(
            "Your Rating",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.sp),
          ),
          toolbarHeight: 60.h,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 120.h,
                width: 120.w,
                child: Image(
                  image: AssetImage("assets/worker.png"),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "2+ Year Experiance",
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
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30.w,
                  ),
                  Text(
                    "Add Rating",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              RatingBar.builder(
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber
                ),updateOnDrag: true,
                onRatingUpdate: (value) {},
              ),
              SizedBox(height: 100.h,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return User_mechanic_list();
                  },));
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
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
