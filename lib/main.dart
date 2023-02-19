import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_disabled_people/screens/admin/add_essay.dart';
import 'package:helping_disabled_people/screens/admin/add_job.dart';
import 'package:helping_disabled_people/screens/admin/add_place.dart';
import 'package:helping_disabled_people/screens/admin/admin_essay.dart';
import 'package:helping_disabled_people/screens/admin/admin_home.dart';
import 'package:helping_disabled_people/screens/admin/admin_jobs.dart';
import 'package:helping_disabled_people/screens/admin/admin_places.dart';
import 'package:helping_disabled_people/screens/admin/fetch_essay.dart';
import 'package:helping_disabled_people/screens/admin/jobs_list.dart';
import 'package:helping_disabled_people/screens/auth/admin_login.dart';
import 'package:helping_disabled_people/screens/auth/login.dart';
import 'package:helping_disabled_people/screens/auth/signup.dart';
import 'package:helping_disabled_people/screens/user/get_job.dart';
import 'package:helping_disabled_people/screens/user/user_essay.dart';
import 'package:helping_disabled_people/screens/user/user_home.dart';
import 'package:helping_disabled_people/screens/user/user_jobs.dart';
import 'package:helping_disabled_people/screens/user/user_places.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : const UserHome(),
      routes: {
        UserHome.routeName: (ctx) => UserHome(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        SignupPage.routeName: (ctx) => SignupPage(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminEssay.routeName: (ctx) => AdminEssay(),
        AddEssay.routeName: (ctx) => AddEssay(),
        AdminJobs.routeName: (ctx) => AdminJobs(),
        AdminPlaces.routeName: (ctx) => AdminPlaces(),
        AddJob.routeName: (ctx) => AddJob(),
        AddPlace.routeName: (ctx) => AddPlace(),
        LoginPage.routeName: (ctx) => LoginPage(),
        UserEssay.routeName: (ctx) => UserEssay(),
        UserJobs.routeName: (ctx) => UserJobs(),
        UserPlaces.routeName: (ctx) => UserPlaces(),
        JobsList.routeName: (ctx) =>JobsList(),
      },
    );
  }
}
