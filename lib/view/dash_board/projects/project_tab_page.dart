import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/models/project_list_modal.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/projectDetailBloc/project_detail_bloc.dart';
import 'package:redwood_app/view/dash_board/projects/project_details_page.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';

import '../../shared_widget/project_list_page.dart';

class ProjectTabPage extends StatefulWidget {
  const ProjectTabPage({Key? key}) : super(key: key);

  @override
  State<ProjectTabPage> createState() => _ProjectTabPageState();
}

class _ProjectTabPageState extends State<ProjectTabPage> {
  TextEditingController searchController = TextEditingController();

  getEvent(GetProfileEvent event) {
    context.read<LoginBloc>().add(event);
  }

  InsertEvent(InsertProjectDetails event) {
    context.read<LoginBloc>().add(event);
  }

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    getEvent(GetProfileEvent(context: context));
    triggerGetListEvent(GetProjectListEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        List<ProjectDetailsList?>? projectDetails;
        String? date = '';
        String? projectCount = '';
        // List<ProjectDetail?>? detailList = state.projectDetailList;
        // String? name = state.name;
        // String? date = state.date;

        if (state is GetProjectListState) {
          if (state.projectList != null && state.projectList!.data != null) {
            date = state.projectList!.data!.currentDate;
            projectCount = state.projectList!.data!.projectCount.toString();
            projectDetails = state.projectList!.data!.projectDetails;
          }
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.notifications_outlined),
                      ),
                    ),
                    CustomLabel(
                      text: date.toString(),
                      color: ColorConst.red,
                      fontFamily: FontConst.MontserratFont,
                      fontWeight: FontWeight.bold,
                      size: 17,
                    ),
                    CustomLabel(
                      // text: name.toString() + '!',
                      text: 'Ashfaque',
                      size: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConst.MontserratFont,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    CustomLabel(
                      text: 'You have $projectCount Project assigned',
                      fontFamily: FontConst.MontserratFont,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Find Your Projects',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      controller: searchController,
                      onChanged: (text) {
                        text = text.toLowerCase();
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetailsPage()));
                        },
                        child: ProjectListPage(
                          itemCount: 1 ,
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
