import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view/dash_board/projects/punch_list_form_page.dart';
import 'package:redwood_app/view/shared_widget/custom_expected_date.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/custom_raised_button.dart';

import '../../../databases/punch_list_dao/punch_list_database.dart';
import '../../../helper/constants/asset_const.dart';
import '../../../view-models/loginbloc/login_bloc.dart';
import '../../../view-models/loginbloc/login_state.dart';

class IssuePageList extends StatefulWidget {
  const IssuePageList({Key? key}) : super(key: key);

  @override
  State<IssuePageList> createState() => _IssuePageListState();
}

class _IssuePageListState extends State<IssuePageList> {

  getEvent(GetPunchList event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    getEvent(GetPunchList(context: context));
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
      print("openPunchList======${state.closePunchList?.length}");
      print("projectLength=====${punchListDetails?.length}");
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: width * 0.25,
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorConst.lightBrown,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: const Offset(0.8, 0.8), //(x,y)
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      punchListDetails!.isEmpty ? Text('${0}') :CustomLabel(
                        text: '${state.openPunchList?.length}',
                        size: width * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomLabel(
                        text: 'Open',
                        size: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: width * 0.25,
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorConst.lightGreen,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: const Offset(0.8, 0.8), //(x,y)
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      punchListDetails.isEmpty ? Text('${0}') :CustomLabel(
                        text: '${state.closePunchList?.length}',
                        size: width * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomLabel(
                        text: 'Closed',
                        size: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: punchListDetails.length,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomLabel(
                                        text: 'ID-001',
                                        size: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomLabel(
                                        text: '16 Jun 22',
                                        size: 16,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomLabel(
                                        text: '(11:00am)',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorConst.lightBrown,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: CustomLabel(
                                          text: punchListDetails[index]?.status  ?? "",
                                          size: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: width * 0.8,
                                    child: CustomLabel(
                                      text: punchListDetails[index]?.beforeDescription  ?? "",
                                      maxlines: 2,
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Visibility(
                                      visible: true,
                                      child: const SizedBox(
                                        height: 5,
                                      )),
                                  CustomExpectedDate(visible: true, date: "16-Jun-2022", text: "Expected Date"),
                                  Visibility(
                                      visible: true,
                                      child: const SizedBox(
                                        height: 5,
                                      )),
                                  CustomExpectedDate(visible: punchListDetails[index]?.status == "Open" ? false : true, date: "16-Jun-2022", text: "Actual Date"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomRaisedButton(
                                      text: punchListDetails[index]?.status == "Open" ? 'Resolve' : "Download",
                                      color: ColorConst.white,
                                      size: 14,
                                      textcolor: ColorConst.red,
                                      sidecolor: ColorConst.red,
                                      height: height * 0.07,
                                      width: width,
                                      fontsFamily: FontConst.MontserratFont,
                                      onpressed: () {
                                        punchListDetails[index]?.status == "Open" ?  Navigator.push(context, MaterialPageRoute(builder: (context) => PunchListFormPage(id: punchListDetails[index]?.id,))) : Container();
                                      })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          CustomRaisedButton(
              text: '+ Add Items',
              color: ColorConst.red,
              size: 14,
              textcolor: ColorConst.white,
              sidecolor: ColorConst.red,
              height: height * 0.07,
              width: width * 0.9,
              fontsFamily: FontConst.MontserratFont,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PunchListFormPage(id: 0,)));
              })
        ],
      ),
    );});
  }
}
