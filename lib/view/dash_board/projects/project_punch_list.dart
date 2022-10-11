import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view/dash_board/projects/issue_page_list.dart';

import '../../../databases/punch_list_dao/punch_list_database.dart';
import '../../../view-models/loginbloc/login_bloc.dart';
import '../../../view-models/loginbloc/login_state.dart';
import 'closed_issue_list.dart';
import 'open_issue_list.dart';

class ProjectPunchList extends StatefulWidget {
  const ProjectPunchList({Key? key}) : super(key: key);

  @override
  State<ProjectPunchList> createState() => _ProjectPunchListState();
}

class _ProjectPunchListState extends State<ProjectPunchList> with TickerProviderStateMixin {
  TabController? _tabController;
  bool allTab = true;

  getPunchListEvent(GetPunchList event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    getPunchListEvent(GetPunchList(context: context));
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          List<PunchList?>? punchListDetails = state.punchListDetails;

          return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 45,
          child: TabBar(
            controller: _tabController,
            // give the indicator a decoration (color and border radius)
            indicatorColor: ColorConst.red,
            labelColor: ColorConst.red,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorWeight: 1.0,
            // indicatorPadding: EdgeInsets.all(10),
            tabs: [
              // first tab [you can add an icon using the icon property]
              Tab(
                  child: SizedBox(
                width: width * 0.18,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tab(
                    text: "All",
                    height: 30,
                  ),
                ),
              )),

              // second tab [you can add an icon using the icon property]
              Tab(
                  child: SizedBox(
                width: width * 0.18,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tab(
                    text: "Open",
                    height: 30,
                  ),
                ),
              )),
              Tab(
                  child: SizedBox(
                width: width * 0.18,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tab(
                    text: "Closed",
                    height: 30,
                  ),
                ),
              )),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // first tab bar view widget
              IssuePageList(),
              // Visibility(
              //   visible: allTab,
              //   child: SizedBox(
              //     height: 20,
              //   ),
              // ),

              // second tab bar view widget
              OpenIssueList(),
              // third tab bar view widget
              // ProjectPunchList(),
              CloseIssueList()
            ],
          ),
        ),
      ],
    );});
  }
}
