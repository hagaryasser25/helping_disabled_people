import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'admin_home.dart';

class AddJob extends StatefulWidget {
  static const routeName = '/addJob';
  const AddJob({super.key});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  var nameController = TextEditingController();
  var reqController = TextEditingController();
  var condController = TextEditingController();

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
                          backgroundImage: AssetImage('assets/images/logo.jfif'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'اسم الوظيفة',
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
                        controller: reqController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'متطلبات الوظيفة',
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
                        controller: condController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'شروط الوظيفة',
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
                          String name = nameController.text.trim();
                          String req = reqController.text.trim();
                          String cond = condController.text.trim();
              
                          if (name.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل اسم الوظيفة');
                            return;
                          }
              
                          if (req.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل متطلبات الوظيفة');
                            return;
                          }
              
                          if (cond.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل شروط الوظيفة');
                            return;
                          }
              
                          User? user = FirebaseAuth.instance.currentUser;
              
                          if (user != null) {
                            String uid = user.uid;
                            int date = DateTime.now().millisecondsSinceEpoch;
              
                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('jobs');
              
                            String? id = companyRef.push().key;
              
                            await companyRef.child(id!).set({
                              'id': id,
                              'date': date,
                              'name': name,
                              'requirments': req,
                              'conditions': cond,
                            });
                          }
                          showAlertDialog(context);
                        },
                        child: Text('حفظ'),
                      ),
                    ),
                    SizedBox(height: 20.h,)
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
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة الوظيفة"),
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
