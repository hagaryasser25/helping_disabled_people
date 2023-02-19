import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/add_essay.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../admin/fetch_essay.dart';
import '../auth/login.dart';
import '../models/essay_model.dart';

class UserEssay extends StatefulWidget {
  static const routeName = '/userEssay';
  const UserEssay({super.key});

  @override
  State<UserEssay> createState() => _UserEssayState();
}

class _UserEssayState extends State<UserEssay> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Essay> essayList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchEssay();
  }

  @override
  void fetchEssay() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("essay");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Essay p = Essay.fromJson(event.snapshot.value);
      essayList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
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
            title: Text('مقالات عن ذو الأعاقة'),
          ),
    
          body: Material(
            child: Column(
              children: [
                Image.asset('assets/images/essay.jfif'),
                Container(
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 15.w,
                      right: 15.w,
                      bottom: 15.h,
                    ),
                    crossAxisCount: 6,
                    itemCount: keyslist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                          
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FetchEssay(
                                title: keyslist[index],
                              );
                            }));
                            
                          },
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w, left: 10.w),
                              child: Center(
                                child: Column(children: [
                                  SizedBox(
                                    height: 70.h,
                                  ),
                                  Text(
                                    '${keyslist[index]}',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor('#58d2e7')),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(3, index.isEven ? 3 : 3),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 5.0,
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
