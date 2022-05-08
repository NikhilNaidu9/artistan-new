import 'package:artistan/pages/profile/user_prompt.dart';
import 'package:artistan/resources/values/app_colors.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController _name = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _profession = TextEditingController();

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
                            MediaQuery.of(context).size.height / 3 + 20,
                          ),
                          TextField(
                            controller: _name,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'NAME',
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
                            controller: _birthday,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'BIRTHDAY',
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
                            controller: _profession,
                            style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK,  fontFamily: 'Open_Sans'),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'PROFESSION',
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
                        onPressed: ()  async {
                          Map<String, dynamic> data = {
                            "name": _name.text,
                            "birthday": _birthday.text,
                            "profession": _profession.text,
                          };
                          bool created = await addArtistUserData(data);

                          UserPrompt(userData: data,);

                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => UserPrompt()));
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
                    'Personal\n'
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