import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/add_job.dart';
import 'package:helping_disabled_people/screens/models/jobsList_model.dart';
import 'package:helping_disabled_people/screens/models/jobs_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class JobsList extends StatefulWidget {
  static const routeName = '/jobsList';
  const JobsList({super.key});

  @override
  State<JobsList> createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<JobsListV> jobsList = [];
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
    base = database.reference().child("userJobs");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      JobsListV p = JobsListV.fromJson(event.snapshot.value);
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
              automaticallyImplyLeading: false,
              backgroundColor: HexColor('#58d2e7'),
              title: Center(child: Text('التقديمات')),
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
                                'الأسم : ${jobsList[index].name.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'العمر : ${jobsList[index].age.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'رقم الهاتف : ${jobsList[index].phoneNumber.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                              Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'اسم الوظيفة : ${jobsList[index].jobName.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                               Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'الخبرة : ${jobsList[index].exp.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                                                             Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'الكلية : ${jobsList[index].faculty.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                                                                                           Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'المؤهل : ${jobsList[index].qualification.toString()}',
                                style: TextStyle(fontSize: 17),
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                              base
                                  .child(jobsList[index].id.toString())
                                  .remove();
                            },
                            child: Icon(Icons.delete,
                                color: Color.fromARGB(255, 122, 122, 122)),
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