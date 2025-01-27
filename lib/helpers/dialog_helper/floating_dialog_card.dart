import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_calculator.dart';
import 'dialog_request.dart';


class FloatingDialogCard extends StatelessWidget {
  final DialogRequest request;
  final VoidCallback dismissDialog;

  const FloatingDialogCard({
    Key? key,
    required this.request,
    required this.dismissDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          const SizedBox(height: 80),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: sizer(true, 10, context),
              vertical: sizer(false, 14, context),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      request.title,
                      style: TextStyle(
                        fontSize: sizer(true, 13, context),
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: sizer(false, 10, context),
                    ),
                  ],
                ),
                Text(
                  request.message,
                  style: TextStyle(
                    fontSize: sizer(true, 13, context),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    height: sizer(true, 1.5, context),
                  ),
                ),
                SizedBox(
                  height: sizer(false, 10, context),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
