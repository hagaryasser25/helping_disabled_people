import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../models/booking_model.dart';
import '../models/doctor_list_model.dart';

class DoctorList extends StatefulWidget {
  static const routeName = '/doctorList';
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<DoctorsBookings> coursesList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDoctors();
  }

  @override
  void fetchDoctors() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("doctorsBookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      DoctorsBookings p = DoctorsBookings.fromJson(event.snapshot.value);
      coursesList.add(p);
      print(coursesList.length);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: HexColor('#58d2e7'),
                title: Text('حجوزات الاطباء')),
            body: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                itemCount: coursesList.length,
                itemBuilder: (BuildContext context, int index) {
                  var date = coursesList[index].date;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 15, left: 15, bottom: 10),
                        child: Column(children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'اسم الدكتور: ${coursesList[index].doctorName.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'تاريخ الأشتراك: ${coursesList[index].date.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: 130.w, height: 45.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#58d2e7'),
                              ),
                              child: Text('بيانات المريض'),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'بيانات المريض',
                                      textAlign: TextAlign.right,
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '${coursesList[index].userEmail.toString()}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 17),
                                              )),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '${coursesList[index].userName.toString()}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 17),
                                              )),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '${coursesList[index].userPhone.toString()}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 17),
                                              )),
                                              Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '${coursesList[index].status.toString()}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 17),
                                              )),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('حسنا'))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                              base
                                  .child(coursesList[index].id.toString())
                                  .remove();
                            },
                            child: Icon(Icons.delete,
                                color: Color.fromARGB(255, 122, 122, 122)),
                          )
                        ]),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  String getDate(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);

    return DateFormat('MMM dd yyyy').format(dateTime);
  }
}