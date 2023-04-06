import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_disabled_people/screens/user/user_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users_model.dart';

class BookDoctor extends StatefulWidget {
  String doctorName;

  static const routeName = '/bookDoctor';
  BookDoctor({required this.doctorName});

  @override
  State<BookDoctor> createState() => _BookDoctorState();
}

class _BookDoctorState extends State<BookDoctor> {
  var dateController = TextEditingController();
  var statusController = TextEditingController();
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  void initState() {
    getUserData();
    super.initState();
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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#58d2e7'),
            title: Text('استمارة الحجز')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(hintText: 'تاريخ الحجز'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: statusController,
                    decoration: InputDecoration(hintText: 'شرح الحالة'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#58d2e7')
                    ),
                      onPressed: () async {
                        String date = dateController.text.trim();
                        String status = statusController.text.trim();
                        User? user = FirebaseAuth.instance.currentUser;

                        if (date.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل تاريخ الحجز');
                          return;
                        }
                        if (status.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل شرح الحالة');
                          return;
                        }

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('doctorsBookings');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'userEmail': currentUser.email,
                            'userName': currentUser.fullName,
                            'userPhone': currentUser.phoneNumber,
                            'doctorName': widget.doctorName,
                            'date': date,
                            'status': status,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child: Text('حجز الآن')),
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
      primary: Colors.blue,
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم الحجز بنجاح'),
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
