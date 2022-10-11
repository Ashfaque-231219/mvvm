import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/view/dash_board/projects/punch_list_form_page.dart';

import '../../../databases/punch_list_dao/punch_list_database.dart';
import '../../../helper/constants/asset_const.dart';
import '../../../helper/constants/color_const.dart';
import '../../../view-models/loginbloc/login_bloc.dart';
import '../../../view-models/loginbloc/login_state.dart';
import '../../shared_widget/custom_expected_date.dart';
import '../../shared_widget/custom_label.dart';
import '../../shared_widget/custom_raised_button.dart';

class CloseIssueList extends StatefulWidget {
  const CloseIssueList({Key? key}) : super(key: key);

  @override
  State<CloseIssueList> createState() => _CloseIssueListState();
}

class _CloseIssueListState extends State<CloseIssueList> {

  getPunchListEvent(GetPunchList event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    GetPunchList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            List<PunchList?>? punchListDetails = state.closePunchList;
            print("openPunchList======${state.closePunchList?.length}");
            print("projectLength=====${punchListDetails?.length}");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: punchListDetails?.length,
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
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(

                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 7,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: ColorConst.lightBrown,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: CustomLabel(
                                                    text: punchListDetails?[index]?.status  ?? "",
                                                    size: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
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
                                              text: punchListDetails?[index]?.beforeDescription  ?? "",
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
                                          CustomExpectedDate(visible: false, date: "16-Jun-2022", text: "Actual Date"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          CustomRaisedButton(
                                              text: 'Download',
                                              color: ColorConst.white,
                                              size: 14,
                                              textcolor: ColorConst.red,
                                              sidecolor: ColorConst.red,
                                              height: height * 0.07,
                                              width: width,
                                              fontsFamily: FontConst.MontserratFont,
                                              onpressed: () {})
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PunchListFormPage()));
                      })
                ],
              ),
            );});
  }
}
