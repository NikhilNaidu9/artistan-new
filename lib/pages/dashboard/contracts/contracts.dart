import 'package:artistan/pages/dashboard/contracts/add_jobs.dart';
import 'package:artistan/pages/dashboard/contracts/user_jobs.dart';
import 'package:artistan/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

class ContractsPage extends StatefulWidget {
  @override
  _ContractsPageState createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      child: Text(
        'Ongoing',
        style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK),
      ),
    ),
    Tab(
      child: Text(
        'Completed',
        style: TextStyle(color: AppColors.PRIMARY_COLOR_DARK),
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: list.length, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: AppColors.PRIMARY_COLOR_DARK,
              labelColor: AppColors.PRIMARY_COLOR_DARK,
              tabs: list,
              controller: _tabController,
            ),
            Container(
              width: width,
              height: height / 1.4,
              child: TabBarView(
                  controller: _tabController,
                  children: [OngoingJobs(), CompletedJobs()]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddJobs(),
            ),
          );
        },
        tooltip: 'Add Jobs',
        backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
        foregroundColor: AppColors.ACCENT_COLOR,
        child: Icon(Icons.add),
      ),
    );
  }
}
