import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_disabled_people/screens/auth/admin_login.dart';
import 'package:helping_disabled_people/screens/auth/signup.dart';
import 'package:helping_disabled_people/screens/user/user_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

import '../admin/admin_home.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/adminLogin';
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              Image.asset(
                'assets/images/2.jfif',
                // height: 180.h,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'تسجيل دخول',
                          style: TextStyle(
                              fontSize: 22, color: HexColor('#073763')),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(),
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: HexColor('#58d2e7'),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'البريد الألكترونى',
                                hintStyle: TextStyle()),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(),
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: HexColor('#58d2e7'),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'كلمة المرور',
                                hintStyle: TextStyle()),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: double.infinity, height: 50.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('#58d2e7'),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: Text(
                              'سجل دخول',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'Please fill all fields');
                                return;
                              }

                               if (email != 'admin@gmail.com') {
                                Fluttertoast.showToast(
                                    msg: 'Wrong email or password');

                                return;
                              }

                              if (password != '123456789') {
                                Fluttertoast.showToast(
                                    msg: 'Wrong email or password');

                                return;
                              }

                              ProgressDialog progressDialog = ProgressDialog(
                                  context,
                                  title: Text('Logging In'),
                                  message: Text('Please Wait'));
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (userCredential.user != null) {
                                  progressDialog.dismiss();
                                  Navigator.pushNamed(
                                      context, AdminHome.routeName);
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  Fluttertoast.showToast(msg: 'User not found');
                                } else if (e.code == 'wrong-password') {
                                  Fluttertoast.showToast(msg: 'Wrong password');
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: 'Something went wrong');
                                progressDialog.dismiss();
                              }
                            },
                          ),
                        ),
                      ],
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
}