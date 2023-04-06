import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/admin_courses.dart';
import 'package:helping_disabled_people/screens/admin/admin_doctors.dart';
import 'package:helping_disabled_people/screens/admin/admin_essay.dart';
import 'package:helping_disabled_people/screens/admin/admin_places.dart';
import 'package:helping_disabled_people/screens/admin/course_list.dart';
import 'package:helping_disabled_people/screens/admin/doctor_list.dart';
import 'package:helping_disabled_people/screens/admin/jobs_list.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth/login.dart';

class AdminList extends StatefulWidget {
  static const routeName = '/adminList';
  const AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
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
            title: Center(child: Text('قائمة الحجوزات')),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/list.jpg',
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
                            Navigator.pushNamed(context, CourseList.routeName);
                          },
                          child: card(Icons.article, 'حجوزات الدورات')),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DoctorList.routeName);
                          },
                          child:
                              card(Icons.add_business, 'حجوزات الأطباء')),
                    ],
                  ),
                ),

              ],
            ),
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
