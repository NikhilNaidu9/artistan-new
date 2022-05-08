import 'package:artistan/pages/auth/signup_page.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:artistan/resources/values/app_colors.dart';

import 'package:artistan/pages/profile/profile_page_one.dart';

import '../dashboard/dashboard.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                            MediaQuery.of(context).size.height / 2 - 50.0,
                          ),
                          TextField(
                            controller: _emailField,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  color: AppColors.PRIMARY_COLOR_DARK),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          TextField(
                            controller: _passwordField,
                            obscureText: true,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  color: AppColors.PRIMARY_COLOR_DARK),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)),
                            ),
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
                          bool signedIn = await signIn(_emailField.text, _passwordField.text);
                          if (signedIn) {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => DashBoardPage()));
                          } else {
                            print('Sign In Failed');
                          }
                        },
                        elevation: 5.0,
                        child: Text(
                          'Login',
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
                            'New Account? ',
                            style: TextStyle(
                                color: AppColors.PRIMARY_COLOR_DARK,
                                fontSize: 20.0,
                                fontFamily: 'Open_Sans'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => SignUpPage()));
                            },
                            child: Text(
                              'Signup',
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
                      padding: const EdgeInsets.fromLTRB(70.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                            color: AppColors.ACCENT_COLOR,
                            fontSize: 35.0,
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
