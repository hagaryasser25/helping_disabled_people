import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helping_disabled_people/screens/admin/admin_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDoctor extends StatefulWidget {
  static const routeName = '/AddDoctorScreen';
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  var specialityController = TextEditingController();
  var codeController = TextEditingController();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var workPlaceController = TextEditingController();
  var expController = TextEditingController();

  String imageUrl = '';
  File? image;

  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

  Future pickImageFromCamera() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#58d2e7'),
          title: Align(
              alignment: Alignment.center, child: Text('أضف بيانات الطبيب')),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: HexColor('#cfe2f3'),
                        backgroundImage:
                            image == null ? null : FileImage(image!),
                      )),
                  Positioned(
                      top: 120,
                      left: 120,
                      child: SizedBox(
                        width: 50,
                        child: RawMaterialButton(
                            // constraints: BoxConstraints.tight(const Size(45, 45)),
                            elevation: 10,
                            fillColor: HexColor('#58d2e7'),
                            child: const Align(
                                // ignore: unnecessary_const
                                child: Icon(Icons.add_a_photo,
                                    color: Colors.white, size: 22)),
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Choose option',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: HexColor('#58d2e7'))),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  pickImageFromDevice();
                                                },
                                                splashColor:
                                                    HexColor('#FA8072'),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(Icons.image,
                                                          color: HexColor('#58d2e7')),
                                                    ),
                                                    Text('Gallery',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                )),
                                            InkWell(
                                                onTap: () {
                                                  pickImageFromCamera();
                                                },
                                                splashColor:
                                                    HexColor('#FA8072'),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(Icons.camera,
                                                          color: HexColor('#58d2e7')),
                                                    ),
                                                    Text('Camera',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                )),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                splashColor:
                                                    HexColor('#FA8072'),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                          Icons.remove_circle,
                                                          color: HexColor('#58d2e7')),
                                                    ),
                                                    Text('Remove',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ))
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'أدخل الأسم'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: specialityController,
              decoration: InputDecoration(hintText: 'ادخل التخصص'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: codeController,
              decoration: InputDecoration(hintText: 'أدخل الكود'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'أدخل سعر الكشف'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: workPlaceController,
              decoration: InputDecoration(hintText: 'أدخل مكان الكشف'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: expController,
              decoration: InputDecoration(hintText: 'ادخل خبرة الطبيب'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      HexColor('#58d2e7')),
                ),
                onPressed: () async {
                  String code = codeController.text.trim();
                  String speciality = specialityController.text.trim();
                  String name = nameController.text.trim();
                  String price = priceController.text.trim();
                  String workPlace = workPlaceController.text.trim();
                  String experience = expController.text.trim();

                  if (speciality.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل تخصص الطبيب');
                    return;
                  }
                  if (imageUrl.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل صورة الطبيب');
                    return;
                  }
                  if (code.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل كود الطبيب');
                    return;
                  }
                  if (name.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل اسم الطبيب');
                    return;
                  }
                  if (price.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل سعر الكشف');
                    return;
                  }
                  if (workPlace.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل مكان عمل الطبيب');
                    return;
                  }
                  if (experience.isEmpty) {
                    Fluttertoast.showToast(msg: 'ادخل نبذة عن خبرة الطبيب');
                    return;
                  }

                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    String uid = user.uid;
                    int date = DateTime.now().millisecondsSinceEpoch;

                    DatabaseReference companyRef =
                        FirebaseDatabase.instance.reference().child('doctors');

                    String? id = companyRef.push().key;

                    await companyRef.child(id!).set({
                      'date': date,
                      'name': name,
                      'code': code,
                      'price': price,
                      'workPlace': workPlace,
                      'exp': experience,
                      'imageUrl': imageUrl,
                      'speciality': speciality,
                      'id': id,
                    });
                  }
                  showAlertDialog(context);
                },
                child: Text('حفظ'))
          ]),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.blue,
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة الطبيب"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
