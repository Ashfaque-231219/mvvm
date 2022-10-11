import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';
import 'package:redwood_app/view/dash_board/reports/site_survey_form_page.dart';
import 'package:redwood_app/view/shared_widget/custom_dropdown.dart';

import '../../../helper/constants/asset_const.dart';
import '../../../models/login/get_report_type.dart';
import '../../shared_widget/custom_label.dart';
import '../../shared_widget/custom_raised_button.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({Key? key}) : super(key: key);

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  addReportType(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    addReportType(ReportTypeEvent(context: context));
    super.initState();
  }

  List<String> items = ['Report Type', 'Maintencence'];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      List<ReportType>? reportTypes = state.reportName;
      debugPrint(reportTypes.toString());
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(ImageConst.backArrow)),
                    SizedBox(
                      width: 20,
                    ),
                    CustomLabel(
                      text: 'Create Reports',
                      size: 22,
                      fontFamily: FontConst.MontserratFont,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.8,
                  child: CustomLabel(
                    alignment: TextAlign.center,
                    text: 'Select according to the type of report you  want to create',
                    maxlines: 2,
                    size: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontConst.MontserratFont,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(width: width * 0.9, child: reportTypes != null ? CustomDropDown(items: reportTypes, id: getReportType) : Container()),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.center,
                  child: CustomRaisedButton(
                      text: 'Proceed',
                      width: width * 0.9,
                      color: ColorConst.red,
                      sidecolor: ColorConst.red,
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SiteSurveyFormPage(
                                      id: 0,
                                    )));
                      })),
            ],
          ),
        ),
      );
    });
  }

  getReportType(var id) {
    debugPrint("DFCSWCCDUHUDHUHUDC");
    debugPrint(id.toString());
  }
}
