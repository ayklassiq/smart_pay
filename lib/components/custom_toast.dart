import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../helpers/colors.dart';
import '../helpers/size_calculator.dart';

class CustomToast extends StatelessWidget {
  final bool? Error ;

  // bool? Error = false;
  const CustomToast({Key? key, required this.text,  this.Error}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Error == false ? AppColors.redColor : AppColors.blueColor,
          width: 1.0,
        ),
        color: Error == false ? AppColors.secondaryRedColor : AppColors.blueLight,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Error == false ? Icons.cancel : Icons.check_circle_outline,
              color: Error == false ? AppColors.redColor : AppColors.blueColor,
              size: sizer(true, 20.0, context),
            ),
          ),
          SizedBox(
            width: sizer(true, 16.0, context),
          ), 

          Text(
            text,
            style: TextStyle(
                height: sizer(true, 1.4, context),
                color: AppColors.text1,
                fontSize: sizer(true, 13.0, context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
