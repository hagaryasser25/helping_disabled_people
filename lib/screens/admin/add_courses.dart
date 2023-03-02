import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_disabled_people/screens/admin/admin_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/courses_model.dart';
import 'admin_courses.dart';

class AddCourse extends StatefulWidget {
  static const routeName = '/AddCourseScreen';
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  var codeController = TextEditingController();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var startController = TextEditingController();
  var durationController = TextEditingController();
  String dropdownValue = 'الخياطة';


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#58d2e7'),
          title: Text('أضف بيانات الدورة التدريبية'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 119, 118, 118)),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: SizedBox(),

                // Step 3.
                value: dropdownValue,
                icon: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 119, 118, 118)),
                ),

                // Step 4.
                items: ['الخياطة','الحاسب الالى','الرسم','النجارة'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 119, 118, 118)),
                      ),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'أدخل الأسم'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(hintText: 'أدخل الكود'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'أدخل سعر الدورة'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: startController,
              decoration: InputDecoration(hintText: 'أدخل تاريخ بدأ الدورة'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(hintText: 'أدخل مدة الدورة'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(113, 211, 212, 1)),
                ),
                onPressed: () async {
                  String code = codeController.text.trim();
                  String name = nameController.text.trim();
                  String price = priceController.text.trim();
                  String start = startController.text.trim();
                  String duration = durationController.text.trim();
                  String speciality = dropdownValue;

                  if (code.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل كود الدورة');
                    return;
                  }
                  if (name.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل اسم الدورة');
                    return;
                  }
                  if (price.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل سعر الدورة');
                    return;
                  }
                  if (start.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل موعد بدأ الدورة');
                    return;
                  }
                  if (duration.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل مدة الدورة');
                    return;
                  }

                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    String uid = user.uid;
                    int date = DateTime.now().millisecondsSinceEpoch;

                    DatabaseReference companyRef =
                        FirebaseDatabase.instance.reference().child('courses');

                    String? id = companyRef.push().key;

                    await companyRef.child(id!).set({
                      'date': date,
                      'name': name,
                      'code': code,
                      'price': price,
                      'startDate': start,
                      'duration': duration,
                      'id': id,
                      'speciality': speciality
                    });
                  }
                  showAlertDialog(context);
                },
                child: Text('حفظ'))
          ]),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.blue,
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم اضافة الدورة'),
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
