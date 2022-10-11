import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/view/shared_widget/ReportsTile.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/custom_search_bar.dart';

import '../../../models/change_pass_model/change_pass_model.dart';
import '../../../view-models/siteSurveyReportBloc/site_survey_report_bloc.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  triggerGetListEvent(SiteSurveyReportEvent event) {
    context.read<SiteSurveyReportBloc>().add(event);
  }

  @override
  void initState() {
    triggerGetListEvent(GetReportListEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<SiteSurveyReportBloc, SiteSurveyReportState>(
      builder: (context, state) {
        List<Data?>? reportsList;
        if (state is GetReportsListState) {
          if (state.reportList != null && state.reportList!.data != null) {
            reportsList = state.reportList!.data! as List<Data?>?;
          }
        }
        debugPrint(reportsList.toString());
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabel(
                      text: "Project Reports",
                      size: 16,
                      fontFamily: FontConst.MontserratFont,
                      fontWeight: FontWeight.w600,
                    ),
                    GestureDetector(onTap: () {}, child: Image.asset(ImageConst.filterImage))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomSearchBar(),
                Expanded(
                  child: reportsList != null && reportsList.isNotEmpty
                      ? ListView.builder(
                          itemCount: reportsList.length,
                          itemBuilder: (context, int index) {
                            return ReportsTile(report: reportsList![index], refresh: refresh);
                          },
                        )
                      : const Center(
                          child: Text("No Record(s) Found."),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  refresh() {
    triggerGetListEvent(GetReportListEvent(context: context));
  }
}
