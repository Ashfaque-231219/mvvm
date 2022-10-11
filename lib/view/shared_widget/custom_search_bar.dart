import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({this.filter = false, this.hint = '', Key? key}) : super(key: key);

  final bool filter;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              contentPadding: EdgeInsets.all(10),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Visibility(
          visible: filter,
          child: SizedBox(
            width: 10,
          ),
        ),
        Visibility(
          visible: filter,
          child: SvgPicture.asset(
            ImageConst.filterImage,
            width: 25,
            height: 23,
          ),
        )
      ],
    );
  }
}
