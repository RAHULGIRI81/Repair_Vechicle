import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repair_vechicle/User/User_mechanic_failed.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'User_mechanic_bill.dart';
import 'User_mechanic_detail.dart';
import 'User_notification.dart';
import 'User_profile.dart';

class User_mechanic_list extends StatefulWidget {
  final int initialTabIndex;
  const User_mechanic_list({super.key, this.initialTabIndex = 0});

  @override
  State<User_mechanic_list> createState() => _User_mechanic_listState();
}

class _User_mechanic_listState extends State<User_mechanic_list>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Get_data_sp();
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex:
        widget.initialTabIndex); // Now 'this' will work as TickerProvider
  }

  var id;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      id = data.getString("User_id");

      print("Get Successful//////////////////");
      print(id);
    });
  }

  Future<void> Getbyid() async {
    Profile = await FirebaseFirestore.instance
        .collection("User_signup_details")
        .doc(id)
        .get();
  }

  DocumentSnapshot? Profile;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    User_mechanic(),
                    Mechanic_request(),
                  ])),
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Container(
                      height: 60,
                      width: 370,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: TabBar(
                          controller: _tabController,
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          indicatorColor: Colors.white,
                          indicator: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          indicatorPadding:
                          EdgeInsets.only(top: 10, bottom: 10),
                          tabs: [
                            Tab(
                              child: Container(
                                height: 60,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Text(
                                      'Mechanic',
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
                                      'Request',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

class User_mechanic extends StatefulWidget {
  const User_mechanic({super.key});

  @override
  State<User_mechanic> createState() => _User_mechanicState();
}

class _User_mechanicState extends State<User_mechanic> {
  @override
  void initState() {
    super.initState();
    Get_data_sp();
  }

  var id;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      id = data.getString("User_id");

      print("Get Successful//////////////////");
      print(id);
    });
  }

  Future<DocumentSnapshot> Getbyid() async {
    FirebaseFirestore firestore =
        FirebaseFirestore.instance; // Replace with actual user ID

    DocumentSnapshot document =
    await firestore.collection('User_signup_details').doc(id).get();
    return document;
  }

  DocumentSnapshot? Profile;

  TextEditingController Search_crtl = TextEditingController();
  String Search_query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade100,
        toolbarHeight: 90.h,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return User_profile();
                  },
                ));
              },
              child: FutureBuilder<DocumentSnapshot>(
                future:
                Getbyid(), // Assuming Getbyid() returns a DocumentSnapshot
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return CircleAvatar(
                      radius: 30.r,
                      backgroundImage:
                      AssetImage('assets/Profile.png') as ImageProvider,
                    );
                  }

                  // Assuming the profile is stored in the "Profile" field of the document
                  var profileData =
                  snapshot.data!.data() as Map<String, dynamic>?;
                  String? profileUrl = profileData?["Profile"];

                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: profileUrl != null
                            ? NetworkImage(profileUrl)
                            : AssetImage('assets/Profile.png') as ImageProvider,
                      ),
                      // other widgets...
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Container(
              height: 45.h,
              width: 260.w,
              child: TextFormField(
                controller: Search_crtl,
                onChanged: (value) {
                  setState(() {
                    Search_query = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.search),
                    hintText: "Search Near By Mechanics",
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return User_notification();
                    },
                  ));
                },
                icon: Icon(
                  Icons.notifications_none_outlined,
                  size: 35.sp,
                ))
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Mechanic_signup_details")
            .where("State", isEqualTo: 1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          final mech_ls = snapshot.data!.docs.where((doc) {
            String Search_Task = doc["Location"].toString().toLowerCase();
            return Search_Task.contains(Search_query);
          }).toList();
          return ListView.builder(
            itemCount: mech_ls.length,
            itemBuilder: (context, index) {
              final doc = mech_ls[index];
              final Mech_list = doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return User_mechanic_detail(
                            mech_id: doc.id,
                            name: Mech_list["Name"],
                            phn_no: Mech_list["Number"],
                            experience: Mech_list["Experience"],
                            profile: Mech_list["Profile"]);
                      },
                    ));
                  },
                  child: Container(
                    child: Card(
                      color: Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 80.w,
                                  width: 80.w,
                                  child: Image(
                                    image: NetworkImage(
                                        "${Mech_list["Profile"] ?? ""}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "${Mech_list["Name"] ?? ""}",
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
                              width: 15.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${Mech_list["Experience"] ?? ""} Of Experience",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${Mech_list["Location"] ?? ""}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${Mech_list["Number"] ?? ""}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.circular(20.r)),
                                  child: Center(
                                    child: Text(
                                      "Available",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
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

class Mechanic_request extends StatefulWidget {
  const Mechanic_request({super.key});

  @override
  State<Mechanic_request> createState() => _Mechanic_requestState();
}

class _Mechanic_requestState extends State<Mechanic_request> {
  @override
  void initState() {
    super.initState();
    Get_data_sp();
  }

  String? id;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      id = data.getString("User_id")??"";

      print("Get Successful//////////////////");
      print(id);
    });
  }

  Future<DocumentSnapshot> Getbyid() async {
    FirebaseFirestore firestore =
        FirebaseFirestore.instance; // Replace with actual user ID

    DocumentSnapshot document =
    await firestore.collection('User_signup_details').doc(id).get();
    return document;
  }

  DocumentSnapshot? Profile;

  TextEditingController Search_crtl = TextEditingController();
  String Search_query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade100,
          toolbarHeight: 90.h,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return User_profile();
                    },
                  ));
                },
                child: FutureBuilder(
                  future: Getbyid(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return CircleAvatar(
                        radius: 30.r,
                        backgroundImage:
                        AssetImage('assets/Profile.png') as ImageProvider,
                      );
                    }

                    var profileData =
                    snapshot.data!.data() as Map<String, dynamic>?;
                    String? profileUrl = profileData?["Profile"];

                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: profileUrl != null
                              ? NetworkImage(profileUrl)
                              : AssetImage('assets/Profile.png')
                          as ImageProvider,
                        ),
                        // other widgets...
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                height: 45.h,
                width: 260.w,
                child: TextFormField(
                  controller: Search_crtl,
                  onChanged: (value) {
                    setState(() {
                      Search_query = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.search),
                      hintText: "Search",
                      hintStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return User_notification();
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 35.sp,
                  ))
            ],
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User_request")
              .where("User_id", isEqualTo: id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            final Mech_detail = snapshot.data!.docs.where((doc) {
              String Search_Task = doc["Mech_name"].toString().toLowerCase();
              return Search_Task.contains(Search_query);
            }).toList();
            return ListView.builder(
              itemCount: Mech_detail.length,
              itemBuilder: (context, index) {
                final doc = Mech_detail[index];
                final Mech_req = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    child: Card(
                      color: Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 20,
                          top: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          "${Mech_req["Mech_name"] ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "${Mech_req["Date"] ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "${Mech_req["Time"] ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${Mech_req["Work"] ?? ""}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Center(
                                        child: Mech_req["Payment"] == 3?
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return User_mechanic_bill(id:doc.id,Amount:Mech_req["Amount"],Name:Mech_req["Mech_name"],Experiance:Mech_req["Mech_experiance"]/*Profile:Mech_req["Mech_profile"]*/);
                                                  },
                                                ));
                                          },
                                          child: Container(
                                            height: 40.h,
                                            width: 130.w,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.r)),
                                            child: Center(
                                              child: Text(
                                                "Pay",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Mech_req["Payment"] == 4
                                            ? InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return User_mechanic_failed();
                                                  },
                                                ));
                                          },
                                          child: Container(
                                            height: 40.h,
                                            width: 130.w,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    20.r)),
                                            child: Center(
                                              child: Text(
                                                "Failed",
                                                style: TextStyle(
                                                    color:
                                                    Colors.white,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Mech_req["Payment"] == 5
                                            ? Container(
                                          height: 50.h,
                                          width: 120.w,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10.r)),
                                          child: Center(
                                            child: Text(
                                              " Payment\nCompleted",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400),
                                            ),
                                          ),
                                        )
                                            : Mech_req["Mech_status"] ==
                                            0
                                            ? Container(
                                          height: 40.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.grey,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  20.r)),
                                          child: Center(
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400),
                                            ),
                                          ),
                                        )
                                            : Mech_req["Mech_status"] == 1
                                            ? Container(
                                          height: 40.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .green,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.r)),
                                          child: Center(
                                            child: Text(
                                              "Approved",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                          ),
                                        )
                                            : Container(
                                          height: 40.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .red,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.r)),
                                          child: Center(
                                            child: Text(
                                              "Rejected",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                          ),
                                        )),
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
            );
          },
        ));
  }
}
