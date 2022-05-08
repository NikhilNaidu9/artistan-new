import 'package:artistan/resources/values/app_colors.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllJobs extends StatefulWidget {
  @override
  _AllJobsState createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: AppColors.ACCENT_COLOR),
      child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("jobs")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 15.0, left: 15.0),
                      child: Container(
                          height: height / 4.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: AppColors.PRIMARY_COLOR_DARK,
                                  width: 2.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: height / 9,
                                        width: height / 9,
                                        decoration: BoxDecoration(
                                            color:
                                            AppColors.PRIMARY_COLOR_DARK),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color: AppColors.ACCENT_COLOR,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            " ${document.data()['job_category']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors
                                                    .PRIMARY_COLOR_DARK,
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            " ${document.data()['provider_name']}",
                                            style: TextStyle(
                                                color: AppColors
                                                    .PRIMARY_COLOR_DARK,
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            " ${document.data()['job_location']}",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Center(
                                              child: Text(
                                                "\$${document.data()['job_rate']}",
                                                style: TextStyle(
                                                    color:
                                                    AppColors.ACCENT_COLOR,
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: AppColors
                                                    .PRIMARY_COLOR_LIGHT),
                                            height: height / 20,
                                            width: width / 7,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Container(
                                  height: 2.0,
                                  width: width,
                                  color: AppColors.PRIMARY_COLOR_DARK,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Apply Now",
                                    style: TextStyle(
                                        color:
                                        AppColors.PRIMARY_COLOR_DARK,
                                        fontSize: 15.0),
                                  ),
                                  Icon(Icons.add_box)
                                ],
                              )

                            ],
                          )),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
