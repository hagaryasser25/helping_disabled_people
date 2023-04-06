import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/user/user_courses.dart';
import 'package:helping_disabled_people/screens/user/user_doctors.dart';
import 'package:helping_disabled_people/screens/user/user_essay.dart';
import 'package:helping_disabled_people/screens/user/user_places.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth/login.dart';
import '../models/users_model.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
          appBar: AppBar(
            backgroundColor: HexColor('#58d2e7'),
            title: Center(child: Text('الصفحة الرئيسية')),
          ),
          drawer: Drawer(
            child: FutureBuilder(
              future: getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (currentUser == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: HexColor('#58d2e7'),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 18.h,
                            ),
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/logo.jfif'),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("معلومات المستخدم",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                        ),
                        title: const Text('اسم المستخدم'),
                        subtitle: Text('${currentUser.fullName}'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                        ),
                        title: const Text('البريد الالكترونى'),
                        subtitle: Text('${currentUser.email}'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                        ),
                        title: const Text('رقم الهاتف'),
                        subtitle: Text('${currentUser.phoneNumber}'),
                      ),
                      Divider(
                        thickness: 0.8,
                        color: Colors.grey,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('تأكيد'),
                                          content: Text(
                                              'هل انت متأكد من تسجيل الخروج'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushNamed(context,
                                                    LoginPage.routeName);
                                              },
                                              child: Text('نعم'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('لا'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                title: Text('تسجيل الخروج'),
                                leading: Icon(Icons.exit_to_app_rounded),
                              )))
                    ],
                  );
                }
              },
            ),
          ),
          body: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/2.jfif',
                  height: 250.h,
                ),
              ),
              Text('الخدمات المتاحة',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 27,
                      color: HexColor('#155564'))),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, UserEssay.routeName);
                          },
                          child: card(Icons.article, 'مقالات عن ذو الأعاقة')),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, UserDoctors.routeName);
                          },
                          child: card(Icons.local_hospital, 'الأطباء')),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, UserCourses.routeName);
                          },
                          child: card(Icons.task, 'الدورات التدريبية')),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, UserPlaces.routeName);
                          },
                          child: card(Icons.park, 'الأماكن الترفيهية')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(icon, String name) {
  return Card(
    color: HexColor("#58d2e7"),
    child: InkWell(
      splashColor: HexColor('#58d2e7'),
      child: Container(
        width: 160.w,
        height: 230.h,
        child: Padding(
          padding: EdgeInsets.only(
            top: 30.h,
            left: 10.w,
          ),
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: HexColor("#FFFFFF"),
                size: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 0.w,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 7.h),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: HexColor('#FFFFFF'),
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ),
  );
}
