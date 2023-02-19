import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/admin_essay.dart';
import 'package:helping_disabled_people/screens/admin/admin_jobs.dart';
import 'package:helping_disabled_people/screens/admin/admin_places.dart';
import 'package:helping_disabled_people/screens/admin/jobs_list.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth/login.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: HexColor('#58d2e7'),
            title: Center(child: Text('الصفحة الرئيسية')),
            actions: [
              IconButton(
                color: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('تأكيد'),
                          content: Text('هل انت متأكد من تسجيل الخروج'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(
                                    context, LoginPage.routeName);
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
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              Image.asset(
                'assets/images/2.jfif',
                height: 250.h,
              ),
              Text('الخدمات المتاحة',
                  style: TextStyle(fontSize: 27, color: HexColor('#155564'))),
              Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                  left: 10.w,
                ),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AdminEssay.routeName);
                        },
                        child: card(Icons.article, 'مقالات عن ذو الأعاقة')),
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AdminJobs.routeName);
                        },
                        child: card(Icons.add_business, 'أضافة وظيفة')),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                  left: 10.w,
                ),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AdminPlaces.routeName);
                        },
                        child: card(Icons.park, 'أضافة اماكن ترفيهية')),
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, JobsList.routeName);
                        },
                        child: card(Icons.list, 'قائمة التقديمات')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(icon, String text) {
  return Container(
    child: Card(
      color: HexColor('#f3f6fa'),
      child: SizedBox(
        width: 160.w,
        height: 185.h,
        child: Column(children: [
          SizedBox(
            height: 30.h,
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: HexColor('#58d2e7'),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#32486d')))
        ]),
      ),
    ),
  );
}
