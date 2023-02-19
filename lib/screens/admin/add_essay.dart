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

class AddEssay extends StatefulWidget {
  static const routeName = '/addEssay';
  const AddEssay({super.key});

  @override
  State<AddEssay> createState() => _AddEssayState();
}

class _AddEssayState extends State<AddEssay> {
  var titleController = TextEditingController();
  var essayController = TextEditingController();

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
                      controller: titleController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#58d2e7'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'عنوان المقال',
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
                      controller: essayController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#58d2e7'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'محتوى المقال',
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
                        String title = titleController.text.trim();
                        String essay = essayController.text.trim();


                        if (title.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل عنوان المقال');
                          return;
                        }

                        if (essay.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل محتوى المقال');
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;
                          int date = DateTime.now().millisecondsSinceEpoch;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('essay').child(title);

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'date': date,
                            'title': title,
                            'essay': essay,

                          });
                        }
                        showAlertDialog(context);
                      },
                      child: Text('حفظ'),
                    ),
                  ),
                ],
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
    content: Text("تم أضافة المقال"),
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