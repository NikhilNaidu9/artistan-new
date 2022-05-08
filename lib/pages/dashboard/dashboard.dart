import 'package:artistan/pages/auth/login_page.dart';
import 'package:artistan/pages/dashboard/jobs/all_jobs.dart';
import 'package:artistan/pages/dashboard/contracts/contracts.dart';
import 'package:artistan/resources/values/app_colors.dart';
import 'package:artistan/services/firebase_api.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  User user = FirebaseAuth.instance.currentUser;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  final List<Widget> _children = [
    AllJobs(),
    ContractsPage(),
    PlaceholderWidget(Colors.green)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.ACCENT_COLOR,
      appBar:  AppBar(
        leading:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.person_outline,color: AppColors.PRIMARY_COLOR_DARK,),
                onPressed: (){
                  scaffoldKey.currentState.openDrawer()?;
                },
              ),
            ),
          ),
        ),
        title: Text('Home', style: TextStyle(
          color: AppColors.PRIMARY_COLOR_DARK,

        ),),
        centerTitle: true,
        backgroundColor: AppColors.ACCENT_COLOR,
        elevation: 0.0,
      ),
      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.uid),
                accountEmail: Text(user.email),
              ),
              ListTile(
                title: Text('All Users'),
                onTap: () {

                },
              ),
              ListTile(
                title: Text('Sign Out'),
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
              )
            ],
          ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.ACCENT_COLOR,
        elevation: 10.0,
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.work, color: AppColors.PRIMARY_COLOR_DARK,),
            label: "Jobs",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.description, color: AppColors.PRIMARY_COLOR_DARK,),
            label: "Contracts",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: AppColors.PRIMARY_COLOR_DARK,),
              label: "Chats"
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
