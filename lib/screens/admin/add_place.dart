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

class AddPlace extends StatefulWidget {
  static const routeName = '/addPlace';
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var priceController = TextEditingController();

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
                          hintText: 'اسم المكان',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: addressController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'العنوان',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: priceController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#58d2e7'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'سعر التذكرة',
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
                          String address = addressController.text.trim();
                          String price = priceController.text.trim();
              
                          if (name.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل اسم المكان');
                            return;
                          }
              
                          if (address.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل عنوان المكان');
                            return;
                          }
              
                          if (price.isEmpty) {
                            Fluttertoast.showToast(msg: 'ادخل سعر التذكرة');
                            return;
                          }
              
                          User? user = FirebaseAuth.instance.currentUser;
              
                          if (user != null) {
                            String uid = user.uid;
                            int date = DateTime.now().millisecondsSinceEpoch;
              
                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('places');
              
                            String? id = companyRef.push().key;
              
                            await companyRef.child(id!).set({
                              'id': id,
                              'date': date,
                              'name': name,
                              'address': address,
                              'price': price,

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
    content: Text("تم أضافة المكان"),
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