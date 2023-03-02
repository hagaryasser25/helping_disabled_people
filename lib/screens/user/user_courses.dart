import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/user/user_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/courses_model.dart';
import '../models/users_model.dart';

class UserCourses extends StatefulWidget {
 static const routeName = '/userCourses';
  const UserCourses({
    super.key
  });

  @override
  State<UserCourses> createState() => _UserCoursesState();
}

class _UserCoursesState extends State<UserCourses> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Courses> coursesList = [];
  List<String> keyslist = [];
  late Users currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCourses();
    getUserData();
  }

  @override
  void fetchCourses() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("courses");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Courses p = Courses.fromJson(event.snapshot.value);
      coursesList.add(p);
      print(coursesList.length);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
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
                appBar: AppBar(
                  backgroundColor: HexColor('#58d2e7'),
                  title: Text('الدورات التدريبية'),
                ),
                body: Container(
                  decoration: BoxDecoration(color: HexColor('#eaf2f8')),
                  child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 15.w,
                      right: 15.w,
                      bottom: 15.h,
                    ),
                    crossAxisCount: 6,
                    itemCount: coursesList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(children: [
                          SizedBox(height: 10.h),
                          Text(
                            '${coursesList[index].speciality.toString()}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5.h),
                          Text('${coursesList[index].name.toString()}'),
                          SizedBox(height: 5.h),
                          Text('${coursesList[index].price.toString()} جنيه'),
                          SizedBox(height: 5.h),
                          Text(
                              'تاريخ البدأ: ${coursesList[index].start.toString()}'),
                          SizedBox(height: 5.h),
                          Text(
                              'لمدة ${coursesList[index].duration.toString()}'),
                          SizedBox(height: 5.h),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: 100.w, height: 35.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#58d2e7'),
                              ),
                              child: Text('حجز الأن'),
                              onPressed: () async {
                                User? user = FirebaseAuth.instance.currentUser;

                                if (user != null) {
                                  String uid = user.uid;
                                  int date =
                                      DateTime.now().millisecondsSinceEpoch;

                                  DatabaseReference companyRef =
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child('coursesBookings');

                                  String? id = companyRef.push().key;

                                  await companyRef.child(id!).set({
                                    'id': id,
                                    'date': date,
                                    'userEmail': currentUser.email,
                                    'userName': currentUser.fullName,
                                    'userPhone': currentUser.phoneNumber,
                                    'code': coursesList[index].code.toString(),
                                  });
                                }
                                showAlertDialog(context);
                              },
                            ),
                          ),
                        ]),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(3, index.isEven ? 3 : 3),
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 5.0,
                  ),
                ),
              )),
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
    content: Text('تم الأشتراك بنجاح'),
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