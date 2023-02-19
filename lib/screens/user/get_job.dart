import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_disabled_people/screens/user/user_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../models/users_model.dart';

class GetJob extends StatefulWidget {
  String jobName;
  static const routeName = '/getJob';
  GetJob({required this.jobName});

  @override
  State<GetJob> createState() => _GetJobState();
}

class _GetJobState extends State<GetJob> {
  var facultyController = TextEditingController();
  var ageController = TextEditingController();
  var expController = TextEditingController();
  var qualificationController = TextEditingController();
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserData();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/images/logo.jfif'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: facultyController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'اسم الكلية',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 8,
                        maxLines: 20,
                        controller: ageController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'العمر',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 200.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 8,
                        maxLines: 20,
                        controller: expController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'الخبرة',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: qualificationController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'المؤهل',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: double.infinity, height: 65.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#58d2e7'),
                        ),
                        onPressed: () async {
                          String faculty = facultyController.text.trim();
                          String age = ageController.text.trim();
                          String exp = expController.text.trim();
                          String qualification =
                              qualificationController.text.trim();
                          String? name = currentUser.fullName;
                          String? phone = currentUser.phoneNumber;

                          if (faculty.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل اسم الكلية');
                            return;
                          }

                          if (age.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل العمر');
                            return;
                          }

                          if (exp.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل الخبرة');
                            return;
                          }

                          if (qualification.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل المؤهل');
                            return;
                          }

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            String uid = user.uid;
                            int date = DateTime.now().millisecondsSinceEpoch;

                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('userJobs');

                            String? id = companyRef.push().key;

                            await companyRef.child(id!).set({
                              'id': id,
                              'date': date,
                              'faculty': faculty,
                              'age': age,
                              'exp': exp,
                              'qualification': qualification,
                              'name': name,
                              'phoneNumber': phone,
                              'jobName': widget.jobName,
                            });
                          }
                          showAlertDialog(context);
                        },
                        child: Text('حفظ'),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم التقديم فى الوظيفة"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
