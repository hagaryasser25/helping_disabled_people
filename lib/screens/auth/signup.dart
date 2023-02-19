import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signupPage';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'انشاء حساب',
                            style: TextStyle(
                                fontSize: 22, color: HexColor('#073763')),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 65.h,
                            child: TextField(
                              controller: nameController,
                              style: TextStyle(),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.text_fields,
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
                                  hintText: 'الأسم',
                                  hintStyle: TextStyle()),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 65.h,
                            child: TextField(
                              controller: phoneNumberController,
                              style: TextStyle(),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
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
                                  hintText: 'رقم الهاتف',
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
                                'انشاء حساب',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              onPressed: () async {
                                var name = nameController.text.trim();
                                var phoneNumber =
                                    phoneNumberController.text.trim();
                                var email = emailController.text.trim();
                                var password = passwordController.text.trim();

                                if (name.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty ||
                                    phoneNumber.isEmpty  ) {
                                  Fluttertoast.showToast(
                                      msg: 'Please fill all fields');
                                  return;
                                }

                                if (password.length < 6) {
                                  // show error toast
                                  Fluttertoast.showToast(
                                      msg:
                                          'Weak Password, at least 6 characters are required');

                                  return;
                                }

                                ProgressDialog progressDialog = ProgressDialog(
                                    context,
                                    title: Text('Signing Up'),
                                    message: Text('Please Wait'));
                                progressDialog.show();

                                try {
                                  FirebaseAuth auth = FirebaseAuth.instance;

                                  UserCredential userCredential =
                                      await auth.createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  User? user = userCredential.user;

                                  if (userCredential.user != null) {
                                    DatabaseReference userRef = FirebaseDatabase
                                        .instance
                                        .reference()
                                        .child('users');

                                    String uid = userCredential.user!.uid;
                                    int dt =
                                        DateTime.now().millisecondsSinceEpoch;

                                    await userRef.child(uid).set({
                                      'name': name,
                                      'email': email,
                                      'uid': uid,
                                      'dt': dt,
                                      'phoneNumber': phoneNumber,
                                    });

                                    Fluttertoast.showToast(msg: 'Success');

                                    Navigator.of(context).pop();
                                  } else {
                                    Fluttertoast.showToast(msg: 'Failed');
                                  }
                                  progressDialog.dismiss();
                                } on FirebaseAuthException catch (e) {
                                  progressDialog.dismiss();
                                  if (e.code == 'email-already-in-use') {
                                    Fluttertoast.showToast(
                                        msg: 'Email is already exist');
                                  } else if (e.code == 'weak-password') {
                                    Fluttertoast.showToast(
                                        msg: 'Password is weak');
                                  }
                                } catch (e) {
                                  progressDialog.dismiss();
                                  Fluttertoast.showToast(
                                      msg: 'Something went wrong');
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      ),
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