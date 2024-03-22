import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import '../helpers/size_calculator.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         body: SafeArea(
             child: Padding(
           padding: EdgeInsets.symmetric(
               horizontal: sizer(true, 37, context), vertical: 20),
           child: SizedBox(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.asset(
                   'assets/icons/thumb.png',
                   width: 48, // Adjust the width as needed
                   height: 48,
                 ),
                 SizedBox(
                   height: sizer(false, 16, context),

                 ),
                 Text(
                   "Congratulations, James",
                   style: TextStyle(
                       fontSize: sizer(true, 24, context),
                       fontWeight: FontWeight.w600,
                       color: AppColors.primary),
                 ),
                 SizedBox(
                   height: sizer(false, 16, context),

                 ),
                 Text(
                   "You’ve completed the onboarding, you can start using",
                   style: TextStyle(
                       fontSize: sizer(true, 16, context),
                       fontWeight: FontWeight.w400,
                       color: AppColors.primary),
                 ),

               ],

             ),
           ),
         )),
    );
  }
}
