import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mechanic_service extends StatefulWidget {
  const Mechanic_service({super.key});

  @override
  State<Mechanic_service> createState() => _Mechanic_serviceState();
}

class _Mechanic_serviceState extends State<Mechanic_service> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_data_sp();
  }

  var mechid;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      mechid = data.getString("id");

      print("Get Successful//////////////////");
      print(mechid);
    });
  }

  Future<void> Delete_service(String id) async {
    await FirebaseFirestore.instance
        .collection("mech_service")
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.h,
          automaticallyImplyLeading: false,
          title: Text(
            'Service',
            style: TextStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Card(
            surfaceTintColor: Colors.blue.shade100,
            color: Colors.blue.shade100,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("mech_service")
                    .where("Mech_id", isEqualTo: mechid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  final service = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: service.length,
                    itemBuilder: (context, index) {
                      final doc = service[index];
                      final services = doc.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${services["Service"] ?? ""}'),
                              IconButton(
                                  onPressed: () {},
                                  icon: IconButton(
                                      onPressed: () {
                                        Delete_service(doc.id);
                                      },
                                      icon: Icon(CupertinoIcons.delete_solid)))
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Add_service();
              },
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 45.sp,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0.r),
              side: BorderSide(color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class Add_service extends StatefulWidget {
  const Add_service({super.key});

  @override
  State<Add_service> createState() => _Add_serviceState();
}

class _Add_serviceState extends State<Add_service> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get_data_sp();
  }

  var mechid;
  Future<void> Get_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      mechid = data.getString("id");

      print("Get Successful//////////////////");
      print(mechid);
    });
  }

  var Service_ctrl = TextEditingController();
  Future<void> Add_service() async {
    FirebaseFirestore.instance
        .collection("mech_service")
        .add({"Service": Service_ctrl.text, "Mech_id": mechid});
    print("Data Added Successfully//////////////");
    Navigator.of(context).pop();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade100,
      title: Text(
        'Add service',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        SizedBox(
          height: 30.h,
        ),
        Form(
          key: formkey,
          child: TextFormField(
            controller: Service_ctrl,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Any Value";
              }
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.r)),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white),
          ),
        ),
        SizedBox(
          height: 90.h,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  Add_service();
                }
              },
              child: Container(
                width: 250.w,
                height: 55.h,
                decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
