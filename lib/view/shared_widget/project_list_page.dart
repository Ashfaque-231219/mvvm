import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../databases/project_details_dao/project_details_database.dart';
import '../../helper/constants/asset_const.dart';
import '../../helper/constants/color_const.dart';
import '../../view-models/loginbloc/login_bloc.dart';
import '../../view-models/loginbloc/login_state.dart';
import 'custom_label.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({required this.itemCount, this.date = '', this.elevation = 3, this.pageType = '', this.projectId = '', Key? key})
      : super(key: key);

  final int itemCount;
  final double elevation;
  final String date;
  final String pageType;
  final String projectId;

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {


  InsertEvent(InsertProjectDetails event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
      List<ProjectDetail?>? detailList = state.projectDetailList;
      String? name = state.name;
      String? date = state.date;
      print('The  $name');
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, int index) {
          return Card(
            color: ColorConst.whites,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: widget.elevation,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 4,
                  ),
                  VerticalDivider(
                    color: widget.pageType == 'detail' ? Colors.white : ColorConst.red,
                    width: 10,
                    thickness: 3,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: ColorConst.blue, borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 90,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article,
                          color: Colors.black,
                          size: 39,
                        ),
                        CustomLabel(
                          text: 'Company',
                          size: 12,
                          fontFamily: FontConst.MontserratFont,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CustomLabel(
                            text: "project ABC",
                            size: 18,
                            fontFamily: FontConst.MontserratFont,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomLabel(
                            text: widget.projectId,
                            size: 13,
                            fontFamily: FontConst.MontserratFont,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: CustomLabel(
                              text: "Milksworks",
                              alignment: TextAlign.center,
                              size: 8,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConst.MontserratFont,
                              color: Colors.black26,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: ColorConst.yellow, borderRadius: BorderRadius.all(Radius.circular(6))),
                            height: 26,
                            width: 65,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: CustomLabel(
                              text: "Facade",
                              size: 8,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConst.MontserratFont,
                              color: Colors.black26,
                            ),
                            decoration: BoxDecoration(color: ColorConst.blue, borderRadius: BorderRadius.all(Radius.circular(6))),
                            height: 26,
                            width: 65,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        detailList?[index]?.address ?? "",
                        style: TextStyle(fontSize: 10, color: Colors.black38),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      CustomLabel(
                        text: widget.date,
                        color: ColorConst.red,
                        fontFamily: FontConst.MontserratFont,
                        size: 12,
                      )
                    ],
                  )
                ],
              ),
              height: 100,
              width: width,
            ),
          );
        });});
  }
}
