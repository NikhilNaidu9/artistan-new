import 'package:artistan/resources/values/app_colors.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class OngoingJobs extends StatefulWidget {
  @override
  _OngoingJobsState createState() => _OngoingJobsState();
}

class _OngoingJobsState extends State<OngoingJobs> {
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
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('jobs')
                  .doc('ongoing')
                  .collection('ongoing')
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
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  height: 20.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          print('press');
                                          await removeJob(document.id);
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: AppColors.PRIMARY_COLOR_DARK,
                                          size: 25.0,
                                        ),
                                      ),
                                      Container(
                                        width: 2.0,
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.PRIMARY_COLOR_DARK),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Map<String, dynamic> userData;
                                          String uid = FirebaseAuth
                                              .instance.currentUser.uid;
                                          DocumentReference documentReference =
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(uid)
                                                  .collection('jobs')
                                                  .doc('ongoing')
                                                  .collection('ongoing')
                                                  .doc(document.id);

                                          documentReference
                                              .snapshots()
                                              .listen((data) {
                                            setState(() {
                                              print('change');
                                              userData = data.data();
                                              print(
                                                'data: $userData',
                                              );
                                              completeJob(
                                                  document.id, userData);
                                            });
                                          });
                                          await removeJob(document.id);
                                        },
                                        child: Icon(
                                          Icons.done_outline,
                                          color: AppColors.PRIMARY_COLOR_DARK,
                                          size: 25.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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

class CompletedJobs extends StatefulWidget {
  @override
  _CompletedJobsState createState() => _CompletedJobsState();
}

class _CompletedJobsState extends State<CompletedJobs> {
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
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('jobs')
                  .doc('completed')
                  .collection('completed')
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
                          height: height / 5.5,
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
                                          ),
                                          SizedBox(
                                            height: height / 50,
                                          ),
                                          Icon(Icons.done_outline, color: Colors.green,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          )),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
