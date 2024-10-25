import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:repair_vechicle/User/User_mechanic_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_mechanic_detail extends StatefulWidget {
  const User_mechanic_detail(
      {super.key,
        required this.mech_id,
        required this.name,
        required this.phn_no,
        required this.experience,
        required this.profile});
  final mech_id;
  final name;
  final phn_no;
  final experience;
  final profile;

  @override
  State<User_mechanic_detail> createState() => _User_mechanic_detailState();
}

class _User_mechanic_detailState extends State<User_mechanic_detail> {
  String? User_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_user();
  }

  String? User_id;
  String? User_user_name;
  String? User_profile;
  String? User_PhoneNo;

  Future<void> Get_user() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? Userid = await preferences.getString('User_id');
    DocumentSnapshot User_details = await FirebaseFirestore.instance
        .collection('User_signup_details')
        .doc(Userid)
        .get();
    if (User_details.exists) {
      setState(() {
        User_user_name = User_details['Name'];
        User_profile = User_details['Profile'];
        User_PhoneNo = User_details['Number'];
        User_id = Userid;
      });
      print(User_user_name);
      print(User_profile);
      print(User_PhoneNo);
      print(User_id);
    }
  }

  String Date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String Time = DateFormat('kk:mm').format(DateTime.now());
  var Location_ctrl = TextEditingController();

  final List<String> _sevices1 = [
    'Fuel leaking',
    'Battery Check',
    'Brake Pad Replacement',
    'Typer Changing',
    'Select'
  ];
  String Selected_item1 = 'Select';

  Future<void> User_request() async {
    FirebaseFirestore.instance.collection("User_request").add({
      "Location": Location_ctrl.text,
      "Date": Date,
      "Time": Time,
      "Mech_id": widget.mech_id,
      "Mech_name": widget.name,
      "Mech_experiance":widget.experience,
      "Mech_profile":widget.profile,
      "Work": Selected_item1,
      "User_id": User_id,
      "User_name": User_user_name,
      "User_profile": User_profile,
      "User_phn_no": User_PhoneNo,
      "Reject_reason":"Rejected",
      "Rating": 0,
      "Amount": 0,
      "Payment": 0,
      "Mech_status": 0,
    });
    print("Data Added Successfully/////////////////");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request Submitted Successfully'),
        backgroundColor: Colors.green,  // You can customize the color
        duration: Duration(seconds: 3), // The duration of the snackbar
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => User_mechanic_list(initialTabIndex: 1),
      ),
    );
  }

  final formkey = GlobalKey<FormState>();

  // final List<String> _sevices2 = [
  //   'Fuel leaking',
  //   'Battery Check',
  //   'Brake Pad Replacement',
  //   'Typer Changing',
  //   'Select'
  // ];
  // String Selected_item2 = 'Select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: Text(
            "Needed Service",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.sp),
          ),
          toolbarHeight: 60.h,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    height: 120.h,
                    width: 120.w,
                    child: Image(
                      image: NetworkImage(widget.profile),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.phn_no,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "${widget.experience} Of Experience",
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
                    height: 90.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Add needed service",
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
                        Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 295.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.blue.shade50,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.blue.shade50,
                                    value: Selected_item1,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black,
                                      size: 35.sp,
                                    ),
                                    items: _sevices1.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        Selected_item1 = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_circle_sharp,
                                  color: Colors.black,
                                  size: 30.sp,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Enter Your Location',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 88),
                              child: TextFormField(
                                controller: Location_ctrl,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Location Is Mandaitory";
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'Breakdown Location',
                                    focusColor: Colors.blue.shade50,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                        BorderRadius.circular(20.r)),
                                    fillColor: Colors.blue.shade50,
                                    filled: true),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 50.w,
                        //       width: 295.w,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15.r),
                        //         color: Colors.blue.shade50,
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(left: 13),
                        //         child: DropdownButtonHideUnderline(
                        //           child: DropdownButton<String>(
                        //             dropdownColor: Colors.blue.shade50,
                        //             value: Selected_item2,
                        //             icon: Icon(
                        //               Icons.keyboard_arrow_down_outlined,
                        //               color: Colors.black,
                        //               size: 35.sp,
                        //             ),
                        //             items: _sevices2.map((String value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Text(
                        //                   value,
                        //                   style: TextStyle(
                        //                     fontSize: 20.sp,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               );
                        //             }).toList(),
                        //             onChanged: (String? newValue) {
                        //               setState(() {
                        //                 Selected_item2 = newValue!;
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 100.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (formkey.currentState!.validate()&&Selected_item1!="Select") {
                              User_request();
                            }
                          },
                          child: Container(
                            height: 60.h,
                            width: 230.w,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                                child: Text(
                                  'Request',
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
          ),
        ));
  }
}
