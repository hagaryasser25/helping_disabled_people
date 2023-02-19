import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/add_job.dart';
import 'package:helping_disabled_people/screens/models/jobs_model.dart';
import 'package:helping_disabled_people/screens/user/get_job.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class UserJobs extends StatefulWidget {
  static const routeName = '/userJobs';
  const UserJobs({super.key});

  @override
  State<UserJobs> createState() => _UserJobsState();
}

class _UserJobsState extends State<UserJobs> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Jobs> jobsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchJobs();
  }

  @override
  void fetchJobs() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("jobs");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Jobs p = Jobs.fromJson(event.snapshot.value);
      jobsList.add(p);
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
              title: Text('الوظائف'),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 10,
                left: 10,
              ),
              child: ListView.builder(
                itemCount: jobsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 15, left: 15, bottom: 10),
                        child: Column(children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'اسم الوظيفة : ${jobsList[index].name.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'متطلبات الوظيفة: ${jobsList[index].requirments.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'شروط الوظيفة: ${jobsList[index].conditions.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                                ConstrainedBox(
                                          constraints: BoxConstraints.tightFor(
                                              width: 140.w, height: 40.h),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: HexColor('#58d2e7'),
                                            ),
                                            child: Text('التقديم فى الوظيفة'),
                                            onPressed: () async {
                                              
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return GetJob(
                                                  jobName: '${jobsList[index].name.toString()}'
                                                );
                                              }));
                                              
                                            },
                                          ),
                                        ),
                          SizedBox(
                            height: 10.h,
                          )
                        ]),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
