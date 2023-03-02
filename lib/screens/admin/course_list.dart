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

class CourseList extends StatefulWidget {
  static const routeName = '/courseList';
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<CourseBookings> coursesList = [];
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
    base = database.reference().child("coursesBookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      CourseBookings p = CourseBookings.fromJson(event.snapshot.value);
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
              title: Text('حجوزات الدورات')),
            body: Padding(
              padding:  EdgeInsets.only(
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
                                'كود الدورة : ${coursesList[index].courseCode.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'حساب المريض : ${coursesList[index].userEmail.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                              Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'اسم المريض : ${coursesList[index].userName.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                              Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'هاتف المريض : ${coursesList[index].userPhone.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'تاريخ الأشتراك: ${getDate(date!)}',
                                style: TextStyle(fontSize: 17),
                              )),
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
