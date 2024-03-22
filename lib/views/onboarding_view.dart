
import 'package:flutter/material.dart';
import 'package:smart_pay/components/buttons/full_button.dart';
import 'package:smart_pay/components/onboarding/onboarding_content.dart';
import 'package:smart_pay/helpers/colors.dart';
import 'package:smart_pay/helpers/routes.dart';
import 'package:smart_pay/helpers/size_calculator.dart';
import 'package:smart_pay/model/onboarding_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentIndex = 0;
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: sizer(true, 37, context), vertical: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, RouteHelper.loginRoute),
                      child: Text('Skip',
                          style: TextStyle(
                              fontSize: sizer(true, 16, context),
                              color: AppColors.blueColor10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _controller,
                        onPageChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                        itemCount: onboardingData.length,
                        itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OnboardingContent(
                                title: onboardingData[index].title,
                                imageSrc: onboardingData[index].imageSrc,
                                description: onboardingData[index].description,
                                dataLength: onboardingData.length,
                                currentIndex: index.toDouble(),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: sizer(false, 10, context),
                ),
                Center(
                  child: Flexible(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: onboardingData.length,
                      effect: const ExpandingDotsEffect(
                          spacing: 4.0,
                          expansionFactor: 5,
                          radius: 50,
                          dotWidth: 7.0,
                          dotHeight: 7.0,
                          strokeWidth: 10,
                          dotColor: AppColors.lightGrey,
                          activeDotColor: AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizer(false, 24, context),
                ),
                SizedBox(
                  width: sizer(false, 287, context),
                  child: FullButton(
                    buttonFunction: (){
                    Navigator.pushNamed(context, RouteHelper.loginRoute);                
                  }, 
                  buttonText: 'Get Started',
                  ),
                )
             
              ],
            ),
          )),
    ));
  }
}
