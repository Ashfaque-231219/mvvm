import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/databases/punch_list_dao/punch_list_database.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/helper/utils/utils.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view/shared_widget/custom_headers.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/custom_raised_button.dart';
import 'package:redwood_app/view/shared_widget/custom_text_field.dart';

import '../../../view-models/loginbloc/login_state.dart';

class PunchListFormPage extends StatefulWidget {
  final int? id;

  const PunchListFormPage({Key? key, this.id}) : super(key: key);

  @override
  State<PunchListFormPage> createState() => _PunchListFormPageState();
}

class _PunchListFormPageState extends State<PunchListFormPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController afterDescriptionController = TextEditingController();
  File? _pickedImage;
  File? _afterPickedImage;
  Uint8List webImage = Uint8List(8);
  Uint8List afterWebImage = Uint8List(8);
  String? date;

  insertEvent(InsertPunchList event) {
    context.read<LoginBloc>().add(event);
  }
  getEvent(GetPunchList event) {
    context.read<LoginBloc>().add(event);
  }

  updateEvent(UpdatePunchList event) {
    context.read<LoginBloc>().add(event);
  }

  getPunchListEvent(GetPunchListByIdEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    getEvent(GetPunchList(context: context));
    getPunchListEvent(GetPunchListByIdEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      PunchList? punchListDetail = state.punchList;
      descriptionController.text =
          widget.id == 0 ? "" : punchListDetail?.beforeDescription ?? "";
      dateController.text =
          widget.id == 0 ? "" : punchListDetail?.expectedCompletionDate ?? "";
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: CustomHeader(
              textFields: 'Punch List',
              visibleLeft: true,
              visibleRight: false,
              rightImage: ImageConst.infoIcon,
              rightButtonPressed: () {},
              leftButtonPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.9,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: const Offset(0.0, 2.0), //(x,y)
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                          child: CustomLabel(
                        text: "Before",
                        size: 16,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomLabel(
                              text: 'Add Image',
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Visibility(
                            visible: widget.id == 0 ? false : true,
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
                                text: "Open",
                                size: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                      widget.id == 0
                          ?
                      GestureDetector(
                              onTap: () async {
                                var filepicked = await pickImage();
                                print("The selected image is $filepicked");
                                if (filepicked != null) {
                                  setState(() {
                                    if (filepicked is Uint8List) {
                                      webImage = filepicked;
                                    } else if (filepicked is File) {
                                      _pickedImage = filepicked;
                                    }
                                  });
                                }
                              },
                              child: DottedBorder(
                                  dashPattern: [4, 4],
                                  strokeWidth: 1,
                                  color: Colors.grey,
                                  radius: Radius.circular(5),
                                  child: _pickedImage == null
                                      ? Container(
                                          height: 170,
                                          width: width * 0.86,
                                          child: Icon(Icons.camera_alt_outlined,
                                              size: 40, color: Colors.grey),
                                        )
                                      : Container(
                                          width: width * 0.86,
                                          height: 170,
                                          child: Image.file(
                                            _pickedImage!,
                                            fit: BoxFit.fill,
                                          ))))
                          : DottedBorder(
                              dashPattern: [4, 4],
                              strokeWidth: 1,
                              color: Colors.grey,
                              radius: Radius.circular(5),
                              child: Container(
                                  width: width * 0.86,
                                  height: 170,
                                  child: Image.file(
                                    File(punchListDetail?.beforeImage ?? ""),
                                    fit: BoxFit.fill,
                                  ))),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomLabel(
                          text: 'Description',
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 200,
                        child: CustomTextField(
                          expands: true,
                          maxLines: null,
                          inputType: TextInputType.multiline,
                          visibleIcon: false,
                          onTextChanged: descriptionController,
                          validator: (String? value) {},
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomLabel(
                          text: 'Expected Completion',
                          size: 10,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 140,
                        child: TextFormField(
                          onTap: () {
                            var newDate =
                                presentDatePicker(context, date ?? '');
                            dateController.text = newDate.toString();
                            print("The selected date is $date");
                          },
                          controller: dateController,
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            prefixText: date ?? '',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  print("The data is ====>>>>>> $date");
                                  presentDatePicker(context, date ?? '');
                                  var newDate =
                                      presentDatePicker(context, date ?? '');
                                  dateController.text = newDate.toString();
                                },
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black26,
                                  size: 18,
                                )),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            )),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.id == 0 ? false : true,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                                child: Align(
                              alignment: Alignment.topLeft,
                              child: CustomLabel(
                                text: "After",
                                size: 16,
                              ),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CustomLabel(
                                    text: 'Add Image',
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () async {
                                  var filepicked = await pickImage();
                                  print("The selected image is $filepicked");

                                  if (filepicked != null) {
                                    setState(() {
                                      if (filepicked is Uint8List) {
                                        afterWebImage = filepicked;
                                      } else if (filepicked is File) {
                                        _afterPickedImage = filepicked;
                                      }
                                    });
                                  }
                                },
                                child: DottedBorder(
                                    dashPattern: [4, 4],
                                    strokeWidth: 1,
                                    color: Colors.grey,
                                    radius: Radius.circular(5),
                                    child: _afterPickedImage == null
                                        ? Container(
                                            height: 170,
                                            width: width * 0.86,
                                            child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 40,
                                                color: Colors.grey),
                                          )
                                        : Container(
                                            width: width * 0.86,
                                            height: 170,
                                            child: Image.file(
                                              _afterPickedImage!,
                                              fit: BoxFit.fill,
                                            )))),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomLabel(
                                  text: 'Description',
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              height: 200,
                              child: CustomTextField(
                                expands: true,
                                maxLines: null,
                                inputType: TextInputType.multiline,
                                visibleIcon: false,
                                onTextChanged: afterDescriptionController,
                                validator: (String? value) {},
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        child: CustomRaisedButton(
                          height: height * 0.07,
                          width: width * 0.97,
                          text: 'Save',
                          textcolor: ColorConst.red,
                          sidecolor: ColorConst.red,
                          onpressed: () {
                            insertEvent(InsertPunchList(
                              beforeImage: _pickedImage!.path,
                              beforeDescription: descriptionController.text,
                              expectedCompletionDate: dateController.text,
                            ));
                          },
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.id ==0 ?
                CustomRaisedButton(
                  height: height * 0.07,
                  width: width * 0.90,
                  text: 'Raise issue',
                  textcolor: ColorConst.white,
                  sidecolor: ColorConst.red,
                  onpressed: () {
                      insertEvent(InsertPunchList(
                        beforeImage: _pickedImage!.path,
                        beforeDescription: descriptionController.text,
                        expectedCompletionDate: dateController.text,
                      ));
                      GetPunchList(context: context);
                      Navigator.pop(context);
                  },
                  color: ColorConst.red,
                  fontsFamily: FontConst.MontserratFont,
                ) : CustomRaisedButton(
                  height: height * 0.07,
                  width: width * 0.90,
                  text:  'Generate Report',
                  textcolor: ColorConst.white,
                  sidecolor: ColorConst.red,
                  onpressed: () {
                      updateEvent(UpdatePunchList(
                          context: context,
                          afterImage: _afterPickedImage?.path,
                          afterDescription: afterDescriptionController.text,
                          actualCompletionDate: DateTime.now().toString()));
                      GetPunchList(context: context);
                      Navigator.pop(context);
                  },
                  color: ColorConst.red,
                  fontsFamily: FontConst.MontserratFont,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
