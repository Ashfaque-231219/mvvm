import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redwood_app/databases/report_dao/report_database.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/models/login/get_report_type.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';
import 'package:redwood_app/view/dash_board/projects/create_reports_page.dart';
import 'package:redwood_app/view/dash_board/reports/site_survey_form_page.dart';
import 'package:redwood_app/view/shared_widget/custom_raised_button.dart';

import '../../helper/utils/utils.dart';
import 'custom_label.dart';

class ProjectReport extends StatefulWidget {
  const ProjectReport({Key? key}) : super(key: key);

  @override
  State<ProjectReport> createState() => _ProjectReportState();
}

class _ProjectReportState extends State<ProjectReport> {

  addReportType(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    addReportType(GetReportTypeEvent(context: context));
    addReportType(GetSiteSurveyDetailsEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          List<Report>? allReports = state.getAllReportType;
          List<SiteSurveyReports?>? allSiteSurveyReports = state.SitesurveyreportDetails;
          print("allReportsComing=====$allSiteSurveyReports");
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allReports?.length,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SiteSurveyFormPage(id: allReports?[index].id,)));
                  },
                  child: Card(
                    child: Container(
                      width: width,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomLabel(
                                    text: allReports?[index].reportName ?? "",
                                    color: ColorConst.red,
                                    size: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.42,
                                        child: Row(
                                          children: [
                                            CustomLabel(
                                              text: formatDateToString(allReports?[index].createdAt ?? "", "dd MMM, yyyy"),
                                              size: width * 0.03,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomLabel(
                                              text: '(11:00am)',
                                              size: width * 0.03,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomLabel(
                                          text: '50 kb',
                                          size: width * 0.03,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageConst.downloadImage,
                            width: 20,
                            height: 27,
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SvgPicture.asset(
                            ImageConst.shareImage,
                            width: 24,
                            height: 27,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
            child: CustomRaisedButton(
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReportPage()));
              },
              color: ColorConst.red,
              text: '+ Create Reports',
              size: 14,
              textcolor: ColorConst.white,
              sidecolor: ColorConst.red,
              height: height * 0.07,
              width: width * 0.97,
              fontsFamily: FontConst.MontserratFont,
            ),
          ),
        ],
      ),
    ); });
  }
}
