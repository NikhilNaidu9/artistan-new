import 'package:artistan/resources/values/app_colors.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddJobs extends StatefulWidget {
  @override
  _AddJobsState createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  List<String> jobCategory = ["Dancer", "Singer", "Drawing", "Comedian"];

  String dropDownValue = "Dancer";
  TextEditingController _rateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.ACCENT_COLOR,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: AppColors.ACCENT_COLOR,
              borderRadius: BorderRadius.circular(height / 80),
              border:
                  Border.all(color: AppColors.PRIMARY_COLOR_DARK, width: 3.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      size: 36.0,
                    ),
                    Container(
                      height: height / 12,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.PRIMARY_COLOR_DARK),
                          borderRadius: BorderRadius.circular(height / 60)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Category:',
                              style: TextStyle(
                                  color: AppColors.PRIMARY_COLOR_DARK,
                                  fontSize: 18.0,
                                  fontFamily: 'Open_Sans'),
                            ),
                            SizedBox(
                              width: width / 10,
                            ),
                            DropdownButton(
                                value: dropDownValue,
                                items: jobCategory
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    dropDownValue = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.people_outline,
                      size: 36.0,
                    ),
                    Container(
                      width: width / 1.5,
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(
                            color: AppColors.PRIMARY_COLOR_DARK,
                            fontFamily: 'Open_Sans'),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'PROVIDER NAME',
                          labelStyle:
                              TextStyle(color: AppColors.PRIMARY_COLOR_DARK),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppColors.PRIMARY_COLOR_DARK)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppColors.PRIMARY_COLOR_DARK)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.map,
                      size: 36.0,
                    ),
                    Container(
                      width: width / 1.5,
                      child: TextField(
                        controller: _locationController,
                        style: TextStyle(
                            color: AppColors.PRIMARY_COLOR_DARK,
                            fontFamily: 'Open_Sans'),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'LOCATION',
                          labelStyle:
                              TextStyle(color: AppColors.PRIMARY_COLOR_DARK),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppColors.PRIMARY_COLOR_DARK)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppColors.PRIMARY_COLOR_DARK)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      size: 36.0,
                    ),
                    Container(
                      width: width / 1.5,
                      child: TextField(
                        controller: _rateController,
                        style: TextStyle(
                            color: AppColors.PRIMARY_COLOR_DARK,
                            fontFamily: 'Open_Sans'),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'HOURLY RATE',
                          labelStyle:
                              TextStyle(color: AppColors.PRIMARY_COLOR_DARK),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppColors.PRIMARY_COLOR_DARK)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: AppColors.PRIMARY_COLOR_DARK)),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    var data = {
                      "job_category": dropDownValue,
                      "provider_name": _nameController.text,
                      "job_location": _locationController.text,
                      "job_rate": _rateController.text,
                      "provider_uid": FirebaseAuth.instance.currentUser.uid
                    };
                    await addOngoingJob(dropDownValue, data);
                    await addAllJob(dropDownValue, data);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: height / 13,
                    width: width / 2,
                    decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR_LIGHT,
                        borderRadius: BorderRadius.circular(height / 50)),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: AppColors.ACCENT_COLOR,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
