
import 'package:flutter/material.dart';

import '../../helpers/colors.dart';
import '../../helpers/size_calculator.dart';



class OnboardingContent extends StatelessWidget {
  const OnboardingContent(
      {Key? key,
      this.title,
      this.description,
      this.imageSrc,
      this.dataLength,
      this.currentIndex})
      : super(key: key);
  final String? title, imageSrc, description;
  final int? dataLength;
  final double? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(vertical: sizer(false, 40, context)),
          child: Center(
            child: Image.asset(
              imageSrc ?? '',
              fit: BoxFit.contain,
              height: sizer(false, 293, context),
              width: sizer(true, 311, context),
            ),
          ),
        ),
        Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: sizer(false, 24, context),
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFProDisplay',
          ),
        ),
        SizedBox(
          height: sizer(false, 16, context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 16, context)),
          child: Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sizer(true, 14, context),
              color: AppColors.textGrey,
              fontWeight: FontWeight.w400,
              fontFamily: 'SFProDisplay',
            ),
          ),
        ),
      ],
    );
  }
}
