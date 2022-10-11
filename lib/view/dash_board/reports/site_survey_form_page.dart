import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/helper/utils/utils.dart';
import 'package:redwood_app/helper/utils/validate.dart';
import 'package:redwood_app/view-models/siteSurveyReportBloc/site_survey_report_bloc.dart';
import 'package:redwood_app/view/shared_widget/custom_dialog.dart';
import 'package:video_player/video_player.dart';

import '../../shared_widget/custom_label.dart';
import '../../shared_widget/custom_raised_button.dart';
import '../../shared_widget/custom_text_field.dart';

class SiteSurveyFormPage extends StatefulWidget {
  final int? id;

  const SiteSurveyFormPage({Key? key, this.id}) : super(key: key);

  @override
  State<SiteSurveyFormPage> createState() => _SiteSurveyFormPageState();
}

class _SiteSurveyFormPageState extends State<SiteSurveyFormPage> {
  final _key = GlobalKey<ScaffoldState>();

  addSiteSurveyFormPage(SiteSurveyReportEvent event) {
    context.read<SiteSurveyReportBloc>().add(event);
  }

  triggerSiteSurveyEvent(SiteSurveyReportEvent event) {
    context.read<SiteSurveyReportBloc>().add(event);
  }

  @override
  void initState() {
    addSiteSurveyFormPage(GetReportByIdEvents(id: widget.id));
    super.initState();
  }

  File? _pickedImage;
  File? _picked360Image;
  File? _video;
  Uint8List webImage = Uint8List(8);
  Uint8List web360Image = Uint8List(8);
  Uint8List webVideo = Uint8List(8);
  ExpandableController siteMeasurementController = ExpandableController(initialExpanded: true);
  ExpandableController uploadLayoutController = ExpandableController(initialExpanded: false);
  ExpandableController upload360Controller = ExpandableController(initialExpanded: false);
  VideoPlayerController? _videoPlayerController;
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController offLoadingController = TextEditingController();
  TextEditingController onnLoadingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<SiteSurveyReportBloc, SiteSurveyReportState>(builder: (context, state) {
      // SiteSurveyReports? details = state.reportDetails;
      // print("details${details?.id ?? 0}");
      // lengthController.text = widget.id == 0 ? "" : details?.length ?? "";
      // widthController.text = widget.id == 0 ? "" : details?.width ?? "";
      // offLoadingController.text = widget.id == 0 ? "" : details?.offloadingLocation ?? "";
      // onnLoadingController.text = widget.id == 0 ? "" : details?.onloadingLocation ?? "";
      // descriptionController.text = widget.id == 0 ? "" : details?.description ?? "";
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          width: width * 0.9,
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(ImageConst.backArrow),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomLabel(
                      text: 'Site Survey Reports',
                      size: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ExpandablePanel(
                controller: siteMeasurementController,
                header: CustomLabel(
                  text: 'Site Measurements',
                  fontWeight: FontWeight.w600,
                  size: 15,
                ),
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                collapsed: const Text(
                  "",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Container(
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
                      SizedBox(
                        width: width * 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: CustomLabel(
                                      text: 'Length',
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextField(
                                    onChanged: (String? value) {
                                      if (lengthController.text.isNotEmpty && widthController.text.isNotEmpty) {
                                        areaController.text = (double.parse(lengthController.text) * double.parse(widthController.text)).toString();
                                      }
                                    },
                                    maxLines: 1,
                                    inputType: TextInputType.number,
                                    // readOnly: widget.id == 0 ? false : true,
                                    visibleIcon: false,
                                    onTextChanged: lengthController,
                                    validator: (String? value) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomLabel(
                                    alignment: TextAlign.center,
                                    text: 'Width',
                                    size: 16,
                                    color: Colors.black26,
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  CustomTextField(
                                    inputType: TextInputType.number,
                                    maxLines: 1,
                                    readOnly: widget.id == 0 ? false : true,
                                    visibleIcon: false,
                                    onTextChanged: widthController,
                                    onChanged: (String? value) {
                                      if (lengthController.text.isNotEmpty && widthController.text.isNotEmpty) {
                                        areaController.text = (double.parse(lengthController.text) * double.parse(widthController.text)).toString();
                                      }
                                    },
                                    validator: (String? value) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: CustomLabel(
                                      text: 'Area',
                                      size: 16,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  CustomTextField(
                                    inputType: TextInputType.number,
                                    maxLines: 1,
                                    readOnly: widget.id == 0 ? false : true,
                                    visibleIcon: false,
                                    onTextChanged: areaController,
                                    validator: (String? value) {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      SizedBox(
                        width: width * 0.88,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: CustomLabel(
                                      text: 'Onloading Location',
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextField(
                                    maxLines: 1,
                                    readOnly: widget.id == 0 ? false : true,
                                    visibleIcon: false,
                                    onTextChanged: onnLoadingController,
                                    validator: (String? value) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: CustomLabel(
                                      text: 'Offloading Location',
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextField(
                                    maxLines: 1,
                                    readOnly: widget.id == 0 ? false : true,
                                    visibleIcon: false,
                                    onTextChanged: offLoadingController,
                                    validator: (String? value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Visibility(
                        visible: widget.id == 0 ? true : false,
                        child: CustomRaisedButton(
                          width: width * 0.9,
                          text: 'Save',
                          color: Colors.white,
                          textcolor: ColorConst.red,
                          sidecolor: ColorConst.red,
                          onpressed: () {
                            checkMeasurements();
                            // addSiteSurveyFormPage(AddSiteSurveyFormEvent(
                            //   length: lengthController.text,
                            //   width: widthController.text,
                            //   onloadingLocation: onnLoadingController.text,
                            //   offloadingLocation: offLoadingController.text,
                            // ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              SizedBox(
                height: 10,
              ),
              ExpandablePanel(
                controller: uploadLayoutController,
                header: CustomLabel(
                  text: 'Upload Layout Plan Images',
                  fontWeight: FontWeight.w600,
                  size: 15,
                ),
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                collapsed: const Text(
                  "",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Container(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomLabel(
                          text: 'Add Image',
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var filepicked = await pickImage();
                          print("The selected image is $filepicked");
                          if (filepicked != null) {
                            setState(() async {
                              if (filepicked is File) {
                                _pickedImage = filepicked;
                                var f = await _pickedImage?.readAsBytes();
                                webImage = f!;
                                print("The webImage is ==========>>>>>>>>>>>>>>>>$webImage");
                                print("The webImage is ==========>>>>>>>>>>>>>>>>$_pickedImage");
                              }
                            });
                          }
                        },
                        child: DottedBorder(
                            dashPattern: const [4, 4],
                            strokeWidth: 1,
                            color: Colors.grey,
                            radius: Radius.circular(5),
                            child: _pickedImage == null
                                ? SizedBox(
                                    height: height * 0.3,
                                    width: width * 0.86,
                                    child: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey),
                                  )
                                : SizedBox(
                                    width: width * 0.86,
                                    height: height * 0.3,
                                    child: Image.file(
                                      _pickedImage!,
                                      fit: BoxFit.fill,
                                    ))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomLabel(
                          text: 'Description',
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: CustomTextField(
                          visibleIcon: false,
                          readOnly: widget.id == 0 ? false : true,
                          onTextChanged: descriptionController,
                          maxLines: null,
                          inputType: TextInputType.multiline,
                          expands: true,
                          validator: (String? value) {},
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: widget.id == 0 ? true : false,
                        child: CustomRaisedButton(
                          width: width * 0.9,
                          text: 'Save',
                          color: Colors.white,
                          textcolor: ColorConst.red,
                          sidecolor: ColorConst.red,
                          onpressed: () {
                            checkLayoutPlan();
                            // addSiteSurveyFormPage(UpdateLayoutPlanImageEvent(image: _video?.path, description: lengthController.text));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              SizedBox(
                height: 10,
              ),
              ExpandablePanel(
                controller: upload360Controller,
                header: CustomLabel(
                  text: 'Upload 360 degree Image / Video',
                  fontWeight: FontWeight.w600,
                  size: 15,
                ),
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                ),
                collapsed: const Text(
                  "",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Container(
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
                      SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomLabel(
                                text: 'Add Image',
                                size: 12,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  pickerDialog();
                                },
                                child: DottedBorder(
                                    dashPattern: const [4, 4],
                                    strokeWidth: 1,
                                    color: Colors.grey,
                                    radius: Radius.circular(5),
                                    child: _video == null
                                        ? _picked360Image == null
                                            ? SizedBox(
                                                height: 170,
                                                width: width,
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : SizedBox(
                                                width: width,
                                                height: 170,
                                                child: Image.file(
                                                  _picked360Image!,
                                                  fit: BoxFit.fill,
                                                ))
                                        : _videoPlayerController!.value.isInitialized
                                            ? AspectRatio(
                                                aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                child: VideoPlayer(_videoPlayerController!),
                                              )
                                            : Center(child: const CircularProgressIndicator()))),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomLabel(
                                text: 'Description',
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 170,
                              child: CustomTextField(
                                visibleIcon: false,
                                onTextChanged: descriptionController,
                                maxLines: null,
                                inputType: TextInputType.multiline,
                                expands: true,
                                validator: (String? value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Visibility(
                        visible: widget.id == 0 ? true : false,
                        child: CustomRaisedButton(
                          width: width * 0.9,
                          text: 'Save',
                          color: Colors.white,
                          textcolor: ColorConst.red,
                          sidecolor: ColorConst.red,
                          onpressed: () {
                            check360ImageVideo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.id == 0 ? true : false,
                child: CustomRaisedButton(
                  width: width * 0.8,
                  text: 'Generate Report',
                  color: ColorConst.red,
                  textcolor: Colors.white,
                  sidecolor: Colors.white,
                  onpressed: () {
                    if (check360ImageVideo()) {
                      String base64Image = base64Encode(webImage);
                      String base64Image360 = base64Encode(_video != null ? webVideo : web360Image);
                      triggerSiteSurveyEvent(
                        AddSiteFormReportEvent(
                          context: context,
                          projectId: '2',
                          length: lengthController.text,
                          width: widthController.text,
                          area: areaController.text,
                          onLoadingLocation: onnLoadingController.text,
                          offLoadingLocation: offLoadingController.text,
                          reportId: 1,
                          description: descriptionController.text,
                          layoutPlanImage: base64Image,
                          image360Degree: base64Image360,
                        ),
                      );
                    }
                    // addSiteSurveyFormPage(AddReportEvent());
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // addSiteSurveyFormPage(GetReportTypeEvent(context: context));
                  },
                ),
              ),
            ],
          ),
        ),
      ));
    });
  }

  pickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const CustomLabel(
            text: "Choose Option :",
          ),
          contentPadding: EdgeInsets.all(10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  var filepicked = await pickImage();
                  print("The selected image is $filepicked");
                  if (filepicked != null) {
                    setState(() async {
                      if (filepicked is File) {
                        _picked360Image = filepicked;
                        var f = await _pickedImage?.readAsBytes();
                        web360Image = f!;
                      }
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: const Center(child: CustomLabel(text: "Image")),
                ),
              ),
              Divider(
                thickness: 1,
                height: 2,
              ),
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  var filepicked = await pickVideo();
                  if (filepicked != null) {
                    setState(() async {
                      if (filepicked is File) {
                        _video = filepicked;
                        var f = await _video?.readAsBytes();
                        webVideo = f!;
                        print("The web video is =========+>>>>>>>>>>>>>>>>>>> $webVideo");
                        _video = File(filepicked.path);
                        _videoPlayerController = VideoPlayerController.network(_video!.path)
                          ..initialize().then((_) {
                            setState(() {
                              _videoPlayerController?.play();
                            });
                          });
                      }
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: const Center(child: CustomLabel(text: "Video")),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bool checkMeasurements() {
    String message = '';
    if (lengthController.text.isEmpty) {
      message = '$message \u2022 Length.\n';
    }
    if (lengthController.text.isNotEmpty && !Validate.isNumericUsingRegularExpression(lengthController.text)) {
      message = "$message \u2022 Invalid Numeric Length.\n";
    }
    if (widthController.text.isEmpty) {
      message = '$message \u2022 Width.\n';
    }
    if (widthController.text.isNotEmpty && !Validate.isNumericUsingRegularExpression(widthController.text)) {
      message = "$message \u2022 Invalid Numeric Width.\n";
    }
    if (areaController.text.isEmpty) {
      message = '$message \u2022 Area.\n';
    }
    if (areaController.text.isNotEmpty && !Validate.isNumericUsingRegularExpression(areaController.text)) {
      message = "$message \u2022 Invalid Numeric Area.\n";
    }
    if (onnLoadingController.text.isEmpty) {
      message = '$message \u2022 OnLoading Location.\n';
    }
    if (offLoadingController.text.isEmpty) {
      message = '$message \u2022 OffLoading Location.\n';
    }
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            text: 'Following field(s) are required: \n$message',
          );
        },
      );
      return false;
    } else {
      siteMeasurementController.value = false;
      uploadLayoutController.value = true;
      return true;
    }
  }

  bool checkLayoutPlan() {
    bool measures = checkMeasurements();
    String validate = '';
    if (measures) {
      if (_pickedImage == null) {
        validate = '$validate \u2022 Image.\n';
      }
      if (descriptionController.text.isEmpty) {
        validate = '$validate \u2022 Description.\n';
      }
      if (validate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              text: 'Following field(s) are required: \n$validate',
            );
          },
        );
        return false;
      } else {
        uploadLayoutController.value = false;
        upload360Controller.value = true;
        return true;
      }
    } else {
      return false;
    }
  }

  bool check360ImageVideo() {
    bool measures = checkLayoutPlan();
    String validate = '';
    if (measures) {
      if (_video == null && _picked360Image == null) {
        validate = '$validate \u2022 Image/Video.\n';
      }
      if (validate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              text: 'Following field(s) are required: \n$validate',
            );
          },
        );
        return false;
      } else {
        uploadLayoutController.value = false;
        upload360Controller.value = true;
        return true;
      }
    } else {
      return false;
    }
  }
}
