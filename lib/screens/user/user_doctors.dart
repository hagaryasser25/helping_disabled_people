import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/add_doctor.dart';
import 'package:helping_disabled_people/screens/admin/add_place.dart';
import 'package:helping_disabled_people/screens/models/places_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/doctors_model.dart';
import 'doctor_details.dart';

class UserDoctors extends StatefulWidget {
  static const routeName = '/userDoctors';
  const UserDoctors({super.key});

  @override
  State<UserDoctors> createState() => _UserDoctorsState();
}

class _UserDoctorsState extends State<UserDoctors> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Doctors> doctorsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDoctors();
  }

  @override
  void fetchDoctors() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("doctors");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Doctors p = Doctors.fromJson(event.snapshot.value);
      doctorsList.add(p);
      print(doctorsList.length);
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
            title: Center(child: Text('الأماكن الترفيهية')),
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
              itemCount: doctorsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorDetails(
                              name: doctorsList[index].name.toString(),
                              exp: doctorsList[index].exp.toString(),
                              workPlaces: doctorsList[index].workPlace.toString(),
                              price: doctorsList[index].price.toString(),
                              imageUrl:doctorsList[index].imageUrl.toString()
                              
                            );
                          }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                        ),
                        child: CircleAvatar(
                          radius: 37,
                          backgroundImage: NetworkImage(
                              '${doctorsList[index].imageUrl.toString()}'),
                        ),
                      ),
                      Text(
                        '${doctorsList[index].name.toString()}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text('${doctorsList[index].speciality.toString()} '),
                      Text('${doctorsList[index].price.toString()} جنيه'),
                    ]),
                  ),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(3, index.isEven ? 3 : 3),
              mainAxisSpacing: 20.0.h,
              crossAxisSpacing: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
