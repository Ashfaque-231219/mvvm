import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view/dash_board/reports/site_survey_form_page.dart';

import '../../models/change_pass_model/change_pass_model.dart';
import 'custom_label.dart';
import 'custom_raised_button.dart';

class ReportsTile extends StatefulWidget {
  const ReportsTile({required this.report, required this.refresh, Key? key}) : super(key: key);
  final Data? report;
  final Function? refresh;

  @override
  State<ReportsTile> createState() => _ReportsTileState();
}

class _ReportsTileState extends State<ReportsTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        width: width,
        // height: height * 0.13,
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  width: width * 0.25,
                  height: height * 0.12,
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: SizedBox(
                    width: width * 0.38,
                    height: height * 0.13,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomLabel(
                              text: "16 Jun 22",
                              size: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomLabel(
                              text: "(11:00am)",
                              size: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CustomLabel(
                              text: "Project RTG",
                              size: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              width: width * 0.002,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: CustomLabel(
                                text: 'Millworks',
                                size: 10,
                                fontFamily: FontConst.MontserratFont,
                              ),
                              width: 50,
                              height: height * 0.025,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: CustomLabel(
                                text: 'Faccade',
                                size: 10,
                                fontFamily: FontConst.MontserratFont,
                              ),
                              width: 50,
                              height: height * 0.025,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: height * 0.07,
                            child: CustomLabel(
                              text: "HDB Tampines 214 Tampines Street 23 #06-65 Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
            SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 10),
            CustomRaisedButton(
              width: width,
              text: 'Site Survey',
              color: Colors.white,
              size: 15,
              textcolor: ColorConst.red,
              sidecolor: ColorConst.red,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SiteSurveyFormPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
