import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import '../helpers/size_calculator.dart';



class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({
    Key? key,
    this.backButtonFn,
  }) : super(key: key);
  final Function? backButtonFn;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.primary,
                size: sizer(true, 24, context),
              ),
            ),
            SizedBox(
              height: sizer(false, 28, context),
            ),
          ],
        ),
      ],
    );
  }
}
