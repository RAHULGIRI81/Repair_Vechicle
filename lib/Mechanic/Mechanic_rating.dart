import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mechanic_rating extends StatefulWidget {
  const Mechanic_rating({super.key});

  @override
  State<Mechanic_rating> createState() => _Mechanic_ratingState();
}

class _Mechanic_ratingState extends State<Mechanic_rating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Rating',
          style: TextStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Text(
            'The rating given to you',
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.w, vertical: 30),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.blue.shade100),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 20,),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                      AssetImage('assets/'
                                          'person1.png'),
                                    ),
                                    SizedBox(height: 15.h,),
                                    Text(
                                      'Name',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Engine work',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                                    SizedBox(height: 10.h,),
                                    Text('Date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                                    Text('Time',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                                    Text('Place',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Rating',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15.sp,
                                        ),
                                        Icon(
                                          Icons.star_border,
                                          size: 15.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3.h,),
                                    Text(
                                      '4/5',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
