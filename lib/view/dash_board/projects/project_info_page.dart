import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/helper/utils/utils.dart';
import 'package:redwood_app/helper/utils/validate.dart';
import 'package:redwood_app/models/project_info_modal.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';

import '../../../view-models/projectDetailBloc/project_detail_bloc.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  PageController? _pageController = PageController();

  int _currentIndex = 0;
  List<String> projectImages = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  triggerProjectInfoEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    projectImages = [ImageConst.walkthruoghImage, ImageConst.splashImage];
    triggerProjectInfoEvent(GetProjectInfoEvent(context: context, projectId: '2'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        ProjectDetails projectDetails = ProjectDetails();
        String date = '';
        if (state is GetProjectInfoState) {
          if (state.projectDetails != null && state.projectDetails!.data != null) {
            if (state.projectDetails!.data!.projectDetails != null && state.projectDetails!.data!.projectDetails![0] != null) {
              projectDetails = state.projectDetails!.data!.projectDetails![0]!;
            }
          }
        }
        if (projectDetails.image != null) {
          projectImages.clear();
          if (projectDetails.image!.contains(',')) {
            projectImages = projectDetails.image!.split(',');
          } else {
            projectImages.add(projectDetails.image!);
          }
        }
        if (projectDetails.projectStartDate != null && projectDetails.projectEndDate != null) {
          date =
              '${Validate.dateFormatterYMDate(projectDetails.projectStartDate!)} - ${Validate.dateFormatterYMDate(projectDetails.projectEndDate!)}';
        }
        debugPrint(projectDetails.toString());
        return SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          color: Colors.white,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    _currentIndex = index;
                                  },
                                );
                              },
                            ),
                            items: projectImages.map(
                              (index) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.network(
                                          index,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: map<Widget>(projectImages, (index, url) {
                                return Container(
                                  width: 5.0,
                                  height: 5.0,
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: _currentIndex == index ? ColorConst.lightGreen : Colors.grey,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                ImageConst.backArrow,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (projectDetails.projectCategories != null)
                      ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var cat in projectDetails.projectCategories!)
                          cat != null
                              ? Container(
                            padding: EdgeInsets.all(
                              3,
                            ),
                            margin: EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              color: colorFromHex(cat.color.toString()),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CustomLabel(
                              text: cat.name.toString(),
                              color: Colors.grey,
                              size: 11,
                            ),
                          )
                              : Container(),
                      ],
                    ),
                  )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: CustomLabel(
                          text: "Project ABC ",
                          size: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Flexible(
                        child: CustomLabel(
                          text: "(Reference No.-001)",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const CustomLabel(
                    text:
                        "HDB Tampines 214 Tampines Street 23 #06-65 HDB Tampines 214 Tampines Street 23 #06-65 Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomLabel(
                    text: "5 Jun 2022 - 5 Jun 2024",
                    fontWeight: FontWeight.w400,
                    maxlines: 1,
                    color: ColorConst.red,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomLabel(
                    text: "Details",
                    fontWeight: FontWeight.w500,
                    size: 15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const CustomLabel(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lacinia sem ut imperdiet dapibus. Curabitur maximus sem vitae ante rhoncus, quis cursus mi tincidunt. Proin vestibulum eros vitae enim efficitur, sit amet elementum urna lobortis. Nam non risus id elit ornare iaculis. Duis in eros metus.",
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LayoutGrid(
                    columnSizes: [1.fr, 1.fr],
                    rowSizes: List.generate(
                      7,
                      (index) => auto,
                    ),
                    rowGap: 10,
                    columnGap: 10,
                    children: List.generate(
                      projectDetails.users!.length,
                      (index) {
                        return Center(
                          child: SizedBox(
                            width: width,
                            child: Card(
                              child: GridTile(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: width * 0.1,
                                          height: width * 0.1,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Image.network(
                                            projectDetails.users![index]?.photo ?? '',
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, url, error) => Image.asset(
                                              ImageConst.walkthruoghImage,
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: CustomLabel(
                                          text: projectDetails.users![index]?.name ?? '',
                                          fontWeight: FontWeight.w500,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomLabel(
                                        text: projectDetails.users![index]?.team ?? '',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.call_outlined,
                                            color: Colors.grey,
                                            size: 13,
                                          ),
                                          Flexible(
                                            child: CustomLabel(
                                              text: projectDetails.users![index]?.phone ?? '',
                                              fontWeight: FontWeight.w400,
                                              size: 11,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
