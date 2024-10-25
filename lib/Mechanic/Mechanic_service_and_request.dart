import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Mechanic_notification.dart';
import 'Mechanic_profile.dart';
import 'Mechanic_service_acc_rej.dart';
import 'Mechanic_status.dart';

class Mechanic_service_and_request extends StatefulWidget {
  const Mechanic_service_and_request({super.key});

  @override
  State<Mechanic_service_and_request> createState() =>
      _Mechanic_service_and_requestState();
}

class _Mechanic_service_and_requestState
    extends State<Mechanic_service_and_request> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_data_sp();
  }

  var id;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      id = data.getString("Mech_id");

      print("Get Successful//////////////////");
      print(id);
    });
  }

  Future<void> Getbyid() async {
    Profile = await FirebaseFirestore.instance
        .collection("Mechanic_signup_details")
        .doc(id)
        .get();
  }

  DocumentSnapshot? Profile;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FutureBuilder(
        future: Getbyid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              toolbarHeight: 170.h,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Mechanic_profile();
                            },
                          ));
                        },
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundImage: NetworkImage(Profile!["Profile"]),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Mechanic_notification();
                              },
                            ));
                          },
                          icon: Icon(
                            Icons.notifications_none_outlined,
                            size: 40.sp,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    height: 60,
                    width: 370,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: TabBar(
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        indicatorColor: Colors.white,
                        indicator: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        indicatorPadding: EdgeInsets.only(top: 10, bottom: 10),
                        tabs: [
                          Tab(
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                    'Requests',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                    'Accepted',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              Mechanic_requests(),
              Mechanic_accepted(),
            ]),
          );
        },
      ),
    );
  }
}

class Mechanic_requests extends StatefulWidget {
  const Mechanic_requests({super.key});

  @override
  State<Mechanic_requests> createState() => _Mechanic_requestsState();
}

class _Mechanic_requestsState extends State<Mechanic_requests> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_data_sp();
  }

  var Mechid;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      Mechid = data.getString("Mech_id");

      print("Get Successful//////////////////");
      print(Mechid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("User_request")
            .where("Mech_id", isEqualTo: Mechid).where("Mech_status",isEqualTo: 0)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          final Mech_detail = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Mech_detail.length,
            itemBuilder: (context, index) {
              final doc = Mech_detail[index];
              final Mech_req = doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Mechanic_service_acc_rej(
                          User_id: doc.id,
                          User_problem: Mech_req["Work"],
                          User_place: Mech_req["Location"],
                          User_phn: Mech_req["User_phn_no"],
                          User_name: Mech_req["User_name"],
                          Date: Mech_req["Date"],
                          Time: Mech_req["Time"],
                        );
                      },
                    ));
                  },
                  child: Container(
                    child: Card(
                      color: Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 50, top: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 90.w,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${Mech_req["User_profile"] ?? ""}"),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius.circular(50.r)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "${Mech_req["Mech_name"] ?? ""}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${Mech_req["Work"] ?? ""}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "${Mech_req["Date"] ?? ""}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "${Mech_req["Time"] ?? ""}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "${Mech_req["Location"] ?? ""}",
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Mechanic_accepted extends StatefulWidget {
  const Mechanic_accepted({super.key});

  @override
  State<Mechanic_accepted> createState() => _Mechanic_acceptedState();
}

class _Mechanic_acceptedState extends State<Mechanic_accepted> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_data_sp();
  }

  var Mechid;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      Mechid = data.getString("Mech_id");

      print("Get Successful//////////////////");
      print(Mechid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("User_request")
            .where("Mech_id", isEqualTo: Mechid).where("Mech_status",isEqualTo: 1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          final Mech_detail = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Mech_detail.length,
            itemBuilder: (context, index) {
              final doc = Mech_detail[index];
              final Mech_acc = doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  child: Card(
                    color: Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 90.w,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${Mech_acc["User_profile"] ?? ""}"),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                    BorderRadius.circular(50.r)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "${Mech_acc["User_name"] ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${Mech_acc["Work"] ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "${Mech_acc["Date"] ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "${Mech_acc["Time"] ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "${Mech_acc["Location"] ?? ""}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child:
                                  Mech_acc["Payment"]==0?
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Mechanic_status(id:doc.id,Work:Mech_acc["Work"],Name:Mech_acc["User_name"],Date:Mech_acc["Date"],Time:Mech_acc["Time"],Profile:Mech_acc["User_profile"]);
                                        },
                                      ));
                                    },
                                    child: Container(
                                      width: 100.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          color: Colors.grey.shade600),
                                      child: Center(
                                        child: Text(
                                          'Payment\nPending',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ):
                                  Mech_acc["Payment"]==4?
                                  Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        'Payment\nFailed',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ):Mech_acc["Payment"]==5?
                                  Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        'Payment\nSuccess',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ):
                                  Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        color: Colors.grey.shade600),
                                    child: Center(
                                      child: Text(
                                        'Payment\nPending',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
