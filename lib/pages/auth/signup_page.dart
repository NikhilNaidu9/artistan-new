import 'package:artistan/pages/auth/login_page.dart';
import 'package:artistan/pages/profile/personal_info.dart';
import 'package:artistan/pages/profile/user_prompt.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:artistan/resources/values/app_colors.dart';

import 'package:artistan/pages/profile/profile_page_one.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _confirmPasswordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                                MediaQuery.of(context).size.height / 3 + 10.0,
                          ),
                          TextFormField(
                            controller: _emailField,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: "EMAIL ADDRESS",
                                labelStyle: TextStyle(
                                    color: AppColors.PRIMARY_COLOR_DARK,
                                    fontFamily: 'Open_Sans')),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          TextFormField(
                            controller: _passwordField,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                labelText: "PASSWORD",
                                labelStyle: TextStyle(
                                    color: AppColors.PRIMARY_COLOR_DARK,
                                    fontFamily: 'Open_Sans')),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          TextFormField(
                            controller: _confirmPasswordField,
                            obscureText: true,
                            decoration: InputDecoration(
                                focusColor: AppColors.PRIMARY_COLOR_DARK,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                labelText: "CONFIRM PASSWORD",
                                labelStyle: TextStyle(
                                    color: AppColors.PRIMARY_COLOR_DARK,
                                    fontFamily: 'Open_Sans')),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      height: 50.0,
                      width: width / 1.3,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            ),
                        color: AppColors.PRIMARY_COLOR_LIGHT,
                        onPressed: () async {
                          if (_passwordField.text ==
                              _confirmPasswordField.text) {
                             bool created = await register(
                                _emailField.text, _confirmPasswordField.text);
                            if (created) {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => PersonalInfo()));

                            }
                          } else {
                            // TODO: Handle different passwords
                            print('Password Not same');
                          }
                        },
                        elevation: 5.0,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: AppColors.ACCENT_COLOR,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Open_Sans'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have account? ',
                            style: TextStyle(
                                color: AppColors.PRIMARY_COLOR_DARK,
                                fontSize: 20.0,
                                fontFamily: 'Open_Sans'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: AppColors.PRIMARY_COLOR_LIGHT,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Open_Sans'),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: AppColors.PRIMARY_COLOR_DARK,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                      child: Text(
                        'Hello,',
                        style: TextStyle(
                            color: AppColors.ACCENT_COLOR,
                            fontSize: 40.0,
                            fontFamily: 'Open_Sans'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70.0, 5.0, 0.0, 0.0),
                      child: Text(
                        'Sign Up!',
                        style: TextStyle(
                            color: AppColors.ACCENT_COLOR,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open_Sans'),
                      ),
                    )
                  ],
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
