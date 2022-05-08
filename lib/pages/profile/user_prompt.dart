import 'package:artistan/pages/dashboard/dashboard.dart';
import 'package:artistan/pages/profile/contact_info.dart';
import 'package:artistan/pages/profile/profile_page_one.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:artistan/resources/values/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserPrompt extends StatefulWidget {
  UserPrompt({Key? key, this.userData?}) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  _UserPromptState createState() => _UserPromptState();
}

class _UserPromptState extends State<UserPrompt> {

  bool selectedOne = true;
  bool selectedTwo = false;

  String userRole = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: height,
              width: width,
              color: AppColors.ACCENT_COLOR,
            child:  Container(
              padding: EdgeInsets.all(8.0),
              height: height,
              width: width,
              color: AppColors.ACCENT_COLOR,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height:  height / 3.4,
                  ),
                  InkWell(
                    onTap: () {
                      print('1');
                      setState(() {
                        selectedOne = true;
                        selectedTwo = false;
                        userRole = 'artist';
                      });
                    },
                    child: Container(
                        height: height / 3.5,
                        width: width - 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: selectedOne == true ? AppColors.PRIMARY_COLOR_LIGHT : AppColors.ACCENT_COLOR
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/artist.png', width: 150.0, height: 150.0,),
                            Text('Artist', style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.PRIMARY_COLOR_DARK
                            ),)
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    height: height / 80,
                  ),
                  InkWell(
                    onTap: () {
                      print('2');
                      setState(() {
                        selectedOne = false;
                        selectedTwo = true;
                        userRole = 'client';
                      });
                    },
                    child: Container(
                        height: height / 3.5,
                        width: width - 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: selectedTwo == true ? AppColors.PRIMARY_COLOR_LIGHT : AppColors.ACCENT_COLOR
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/client.png', width: 150.0, height: 150.0,),
                            Text('Client', style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.PRIMARY_COLOR_DARK
                            ),)
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Container(
                    height: 50.0,
                    width: width / 2,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: AppColors.PRIMARY_COLOR_LIGHT,
                      onPressed: ()  {
                        String email = FirebaseAuth.instance.currentUser.email;
                        if (selectedOne)  {
                          print('artist selected');
                          Map<String, dynamic> data = {
                            "email": email,
                          };
                           addArtistUserData(widget.userData);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => ContactInfo()));
                        }  else {
                          print('client selected');
                          Map<String, dynamic> data = {
                            "email": email,
                          };
                          addClientUserData(data);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => DashBoardPage()));
                        }
                      },
                      elevation: 5.0,
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: AppColors.ACCENT_COLOR,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open_Sans'),
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: AppColors.PRIMARY_COLOR_DARK,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 60.0, 0.0, 0.0),
                  child: Text(
                    'Who are you?',
                    style: TextStyle(
                        color: AppColors.ACCENT_COLOR,
                        fontSize: 40.0,
                        fontFamily: 'Open_Sans'),
                  ),
                )),
          ),
        ],
      ),
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

