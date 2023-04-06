import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/doctors_model.dart';
import 'book_doctor.dart';

class DoctorDetails extends StatefulWidget {
  String name;
  String exp;
  String workPlaces;
  String price;
  String imageUrl;

  DoctorDetails(
      {required this.name,
      required this.exp,
      required this.workPlaces,
      required this.price,
      required this.imageUrl});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: ((context, child) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: HexColor('#58d2e7'),
                    title: Align(
                        alignment: Alignment.center,
                        child: Text('بيانات الطبيب')),
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(
                      top: 50.h,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  widget.imageUrl),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'الخبرة : ${widget.exp}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'مكان العمل : ${widget.workPlaces}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'سعر الكشف : ${widget.price} جنيه',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: 150.w, height: 50.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#58d2e7'),
                              ),
                              child: Text('حجز الأن'),
                              onPressed: () {
                                
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BookDoctor(
                                   doctorName: '${widget.name}',
                                );
                              }));
                              
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
