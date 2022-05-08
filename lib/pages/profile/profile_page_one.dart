import 'package:artistan/pages/profile/user_prompt.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:artistan/resources/values/app_colors.dart';

class ProfilePageOne extends StatefulWidget {
  @override
  _ProfilePageOneState createState() => _ProfilePageOneState();
}

class _ProfilePageOneState extends State<ProfilePageOne> {
  TextEditingController _firstNameField = TextEditingController();
  TextEditingController _lastNameField = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zip = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          height: height,
          width: width,
          color: AppColors.PRIMARY_COLOR_DARK,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Theme(
                  data: ThemeData(
                      primaryColor: AppColors.ACCENT_COLOR,
                      primaryColorDark: AppColors.ACCENT_COLOR,
                      cursorColor: AppColors.ACCENT_COLOR,
                      hintColor:  AppColors.ACCENT_COLOR,
                      inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.ACCENT_COLOR)
                        )
                      )),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: width / 12, right: width / 12, top: 30.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _firstNameField,
                          style: TextStyle(color: AppColors.ACCENT_COLOR,  fontFamily: 'Open_Sans'),
                          decoration: InputDecoration(
                            labelText: 'FIRST NAME',
                            labelStyle: TextStyle(
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        TextField(
                          controller: _lastNameField,
                          cursorColor: AppColors.ACCENT_COLOR,
                          style: TextStyle(color: AppColors.ACCENT_COLOR,  fontFamily: 'Open_Sans'),
                          decoration: InputDecoration(
                            labelText: 'LAST NAME',
                            labelStyle: TextStyle(
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        TextField(
                          controller: _address,
                          style: TextStyle(color: AppColors.ACCENT_COLOR,  fontFamily: 'Open_Sans'),
                          decoration: InputDecoration(
                            labelText: 'ADDRESS',
                            labelStyle: TextStyle(
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        TextField(
                          controller: _city,
                          style: TextStyle(color: AppColors.ACCENT_COLOR,  fontFamily: 'Open_Sans'),
                          decoration: InputDecoration(
                            labelText: 'CITY',
                            labelStyle: TextStyle(
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        TextField(
                          controller: _state,
                          style: TextStyle(color: AppColors.ACCENT_COLOR,  fontFamily: 'Open_Sans'),
                          decoration: InputDecoration(
                            labelText: 'STATE',
                            labelStyle: TextStyle(
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 26,
                        ),
                        TextFormField(
                          controller: _zip,
                          style: TextStyle(color: AppColors.ACCENT_COLOR, fontFamily: 'Open_Sans'),
                          decoration: InputDecoration(
                            labelText: 'ZIP',
                            labelStyle: TextStyle(
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.ACCENT_COLOR)),
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 50.0,
                  width: width / 1.3,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.red)),
                    color: AppColors.PRIMARY_COLOR_LIGHT,
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        "first_name": _firstNameField.text,
                        "last_name": _lastNameField.text,
                        "address": _address.text,
                        "city": _city.text,
                        "state": _state.text,
                        "zip": _zip.text,
                      };
                      bool created = await addArtistUserData(data);
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
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    'Page 1 of 2',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontFamily: 'Open_Sans'),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
