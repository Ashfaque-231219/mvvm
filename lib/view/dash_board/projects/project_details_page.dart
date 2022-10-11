import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/databases/punch_list_dao/punch_list_database.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view/dash_board/projects/project_info_page.dart';
import 'package:redwood_app/view/dash_board/projects/project_punch_list.dart';
import 'package:redwood_app/view/shared_widget/custom_headers.dart';
import 'package:redwood_app/view/shared_widget/project_list_page.dart';
import 'package:redwood_app/view/shared_widget/project_report.dart';

import '../../../databases/project_details_dao/project_details_database.dart';
import '../../../view-models/loginbloc/login_bloc.dart';
import '../../../view-models/loginbloc/login_state.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  InsertEvent(InsertProjectDetails event) {
    context.read<LoginBloc>().add(event);
  }
  getPunchListEvent(GetPunchList event) {
    context.read<LoginBloc>().add(event);
  }


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    getPunchListEvent(GetPunchList(context: context));
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
      List<ProjectDetail?>? detailList = state.projectDetailList;
      List<PunchList?>? punchListDetails = state.punchListDetails;
      String? name = state.name;
      String? date = state.date;
      print('The  $name');
      return
        Scaffold(
            backgroundColor: ColorConst.whites,
          appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: CustomHeader(
            textFields: 'Project Details',
            visibleLeft: true,
            visibleRight: true,
            rightImage: ImageConst.infoIcon,
            rightButtonPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectInfo()));
            },
            leftButtonPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          ProjectListPage(
            pageType: 'detail',
            projectId: "(Reference no -002)",
            elevation: 0,
            itemCount: 1,
            date: '5 Jun 2002 - 5 Jun 2024',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                height: 45,
                child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(color: ColorConst.red, borderRadius: BorderRadius.circular(7)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Reports',
                    ),

                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Maintenance',
                    ),
                    Tab(
                      text: 'Punch List ',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                ProjectReport(),

                // second tab bar view widget
                Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black26),
                  ),
                ),
                // third tab bar view widget
                ProjectPunchList()
              ],
            ),
          ),
        ],
      ),
    );});
  }
}
