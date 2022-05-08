import 'package:artistan/pages/profile/hourly_rate_info.dart';
import 'package:artistan/pages/profile/profile_page_one.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:artistan/resources/values/app_colors.dart';
import 'package:flutter/widgets.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {

  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zip = TextEditingController();

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
                            MediaQuery.of(context).size.height / 3,
                          ),
                          TextField(
                            controller: _address,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'ADDRESS',
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
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          TextField(
                            controller: _city,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'CITY',
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
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          TextField(
                            controller: _state,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'STATE',
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
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          TextField(
                            controller: _zip,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ZIP CODE',
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
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          TextField(
                            controller: _phoneNumber,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'PHONE NUMBER',
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
                      height: 10.0,
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
                          Map<String, dynamic> data = {
                            "address": _address.text,
                            "city": _city.text,
                            "state": _state.text,
                            "zip": _zip.text,
                          };
                          bool created = await addArtistUserData(data);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => HourlyRateInfo()));
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
              )),
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: AppColors.PRIMARY_COLOR_DARK,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                  child: Text(
                    'Contact\n'
                        'Information',
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


