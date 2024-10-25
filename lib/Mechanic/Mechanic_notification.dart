import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Mechanic_notification extends StatefulWidget {
  const Mechanic_notification({super.key});

  @override
  State<Mechanic_notification> createState() => _Mechanic_notificationState();
}

class _Mechanic_notificationState extends State<Mechanic_notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text(
          "Notification",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp),
        ),
        toolbarHeight: 60.h,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Admin_notification")
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
    return Text("${snapshot.error}");
    }
    final Notification = snapshot.data?.docs ?? [];
        return ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            final doc = Notification[index];
            final Notification_detail = doc.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${Notification_detail?["Matter"]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.sp)),
                            Text("${Notification_detail?["Matter_details"]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp)),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${Notification_detail?["createdAt"]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.sp)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );}
      )
    );
  }
}
