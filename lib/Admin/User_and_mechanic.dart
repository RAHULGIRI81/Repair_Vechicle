
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Mechanic.dart';
import 'User.dart';

class UserAndMech_ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 95,
            backgroundColor: Colors.blue.shade50,
            title: CircleAvatar(
              backgroundImage: AssetImage("assets/Profile.png"),
              radius: 27,
            ),
          ),
          body: Column(
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                TabBar(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade400,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'User',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Mechanic',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    User(), // Call the first class
                    Mechanic(),
                    // Call the second class
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("User_signup_details")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          final User_signup = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: User_signup.length,
            itemBuilder: (context, index) {
              final doc = User_signup[index];
              final User_details = doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return User_page(id: doc.id);
                      },
                    ));
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),

                              image: DecorationImage(
                                image: NetworkImage(
                                    "${User_details["Profile"] ?? ""}"),fit: BoxFit.cover
                              ),
                            ),
                          ),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    "${User_details["Name"] ?? ""}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${User_details["Location"] ?? ""}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${User_details["Number"] ?? ""}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${User_details["Email"] ?? ""}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            // itemCount: 20,
          );
        },
      ),
    );
  }
}

class Mechanic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Mechanic_signup_details")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          final Mechanic_signup = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Mechanic_signup.length,
            itemBuilder: (context, index) {
              final doc = Mechanic_signup[index];
              final Mechanic_details = doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Mechanic_page(id : doc.id);
                      },
                    ));
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("${Mechanic_details["Profile"] ?? ""}"),
                                )),
                          ),
                          SizedBox(width: 10.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 82),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Text(
                                      "${Mechanic_details["Name"] ?? ""}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${Mechanic_details["Number"] ?? ""}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${Mechanic_details["Location"] ?? ""}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Text(
                                    '${Mechanic_details["Experience"] ?? ""}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 9,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            // itemCount: 20,
          );
        },
      ),
    );
  }
}
