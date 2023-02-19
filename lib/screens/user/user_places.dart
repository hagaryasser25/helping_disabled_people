import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helping_disabled_people/screens/admin/add_place.dart';
import 'package:helping_disabled_people/screens/models/places_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class UserPlaces extends StatefulWidget {
  static const routeName = '/userPlaces';
  const UserPlaces({super.key});

  @override
  State<UserPlaces> createState() => _UserPlacesState();
}

class _UserPlacesState extends State<UserPlaces> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Places> placesList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchPlaces();
  }

  @override
  void fetchPlaces() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("places");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Places p = Places.fromJson(event.snapshot.value);
      placesList.add(p);
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
            title: Text('الأماكن الترفيهية'),
          ),
          body: Container(
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
              itemCount: placesList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 10.w),
                      child: Center(
                        child: Column(children: [
                          SizedBox(height: 30.h,),
                          Text(
                            '${placesList[index].name.toString()}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                ),
                          ),
                           Center(
                             child: Text(
                              '${placesList[index].address.toString()}',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                  fontSize: 18,
                                 ),
                          ),
                           ),
                           Text(
                            '${placesList[index].price.toString()}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                                fontSize: 18,
                               ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(3, index.isEven ? 3 : 3),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}