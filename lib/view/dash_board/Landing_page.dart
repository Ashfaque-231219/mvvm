import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/helper/constants/redwood_icon_icons.dart';
import 'package:redwood_app/view/dash_board/profile_page.dart';
import 'package:redwood_app/view/dash_board/projects/project_tab_page.dart';
import 'package:redwood_app/view/dash_board/projects/reports_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  int pageIndex = 0;
  List page = [
    ProjectTabPage(),
    ReportPage(),
    ProfilePage(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit from App'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    pageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: _onWillPop,
      child: Scaffold(
        body: page[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.1,
      decoration: BoxDecoration(
        color: ColorConst.red,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                        RedwoodIcon.project_active,
                        color: Colors.white,
                        size: 40,
                      )
                    : const Icon(
                        RedwoodIcon.project_inactive,
                        color: Colors.white,
                        size: 40,
                      ),
              ),
            ],
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    RedwoodIcon.report_active,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    RedwoodIcon.report_inactive,
                    color: Colors.white,
                    size: 40,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    RedwoodIcon.profile_active,
                    color: Colors.white,
                    size: 40,
                  )
                : const Icon(
                    RedwoodIcon.profile_inactive,
                    color: Colors.white,
                    size: 40,
                  ),
          ),
        ],
      ),
    );
  }
}
