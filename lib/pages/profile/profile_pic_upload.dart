import 'dart:io';

import 'package:artistan/pages/dashboard/dashboard.dart';
import 'package:artistan/resources/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProfilePicUpload extends StatefulWidget {
  @override
  _ProfilePicUploadState createState() => _ProfilePicUploadState();
}

class _ProfilePicUploadState extends State<ProfilePicUpload> {

    String userName = 'Name';
    var user_data;
    File _imageFile;
    bool imageStatus = false;

    final imagePicker = ImagePicker();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('artists')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('data')
        .doc('profile');

    documentReference.snapshots().listen((data) {
        print('change');
        setState(() {
          user_data = data.data();
          user_data = user_data.values.toList();
          print(user_data);
          userName = user_data[5];
        });
    }
    );
  }

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery
          .of(context)
          .size
          .width;
      double height = MediaQuery
          .of(context)
          .size
          .height;
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Container(
                height: height,
                width: width,
                color: AppColors.ACCENT_COLOR,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(left: width / 12, right: width / 12),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height:
                              height / 3,
                            ),
                            Text(
                              'Would you like to add a profile photo?',
                              style: TextStyle(
                                  color: AppColors.PRIMARY_COLOR_DARK,
                                  fontSize: 20.0,
                                  fontFamily: 'Open_Sans'),
                            ),
                            SizedBox(
                              height: height / 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: height / 4,
                                width:  height / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(height / 8),
                                  border: Border.all(
                                    color: AppColors.PRIMARY_COLOR_DARK,
                                    width: 2.0
                                  )
                                ),
                                child: Center(child: InkWell(
                                    onTap: () async {
                                      final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
                                      setState(() {
                                        _imageFile = File(pickedFile.path);
                                        imageStatus = true;
                                      });
                                    },
                                    child: Icon(imageStatus ? Icons.done: Icons.add, size: 50.0,))),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 15,
                      ),
                      Container(
                        height: 50.0,
                        width: width / 1.8,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: AppColors.PRIMARY_COLOR_LIGHT,
                          onPressed: () async {
                            uploadImageToFirebaseStorage(context);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => DashBoardPage()));
                          },
                          elevation: 5.0,
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: AppColors.ACCENT_COLOR,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Open_Sans'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 35,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => DashBoardPage()));
                        },
                        child: Text(
                          'Skip Now',
                          style: TextStyle(
                              color: AppColors.PRIMARY_COLOR_DARK,
                              fontSize: 20.0,
                              fontFamily: 'Open_Sans'),
                        ),
                      ),
                    ],
                  ),
                )),
            ClipPath(
              clipper: ClippingClass(),
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: AppColors.PRIMARY_COLOR_DARK,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                    child: Text(
                      'Hey,\n'
                          '${userName}',
                      style: TextStyle(
                          color: AppColors.ACCENT_COLOR,
                          fontSize: 40.0,
                          fontFamily: 'Open_Sans'),
                    ),
                  )
              ),
            ),
          ],
        ),
      );
    }

    Future uploadImageToFirebaseStorage(BuildContext context) async {
      String filename = basename(_imageFile.path);
      StorageReference firebaseRef = FirebaseStorage.instance.ref().child('uploads/$filename');
      StorageUploadTask uploadTask = firebaseRef.putFile(_imageFile);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      taskSnapshot.ref.getDownloadURL().then(
          (value) => print('Done: $value'),
      );
    }

  }


  class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
  var path = Path();
  path.lineTo(0.0, size.height - 50);
  var firstControlPoint = Offset(size.width / 4, size.height);
  var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
  path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
  firstEndPoint.dx, firstEndPoint.dy);

  var secondControlPoint =
  Offset(size.width - (size.width / 3.25), size.height - 65);
  var secondEndPoint = Offset(size.width, size.height - 40);
  path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
  secondEndPoint.dx, secondEndPoint.dy);
  path.lineTo(size.width, size.height - 60);
  path.lineTo(size.width, 0.0);
  path.close();

  return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
  return false;
  }

  }
