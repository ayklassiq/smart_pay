import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


import '../views/HomeScreen.dart';
import '../views/authentication/Id_screen.dart';
import '../views/authentication/confirmation_screen.dart';
import '../views/authentication/create_new_Paasword.dart';
import '../views/authentication/create_pin_screen.dart';
import '../views/authentication/login_screen.dart';
import '../views/authentication/otp_authentication_screen.dart';
import '../views/authentication/signup_screen.dart';
import '../views/authentication/verify_identity_screen.dart';
import '../views/dashboard/dashboard.dart';
import '../views/onboarding_view.dart';
import '../views/splashScreen.dart';
import 'dialog_helper/dialog_manager.dart';

class RouteHelper {
  static const String loginRoute = "Login";
  static const String forgotPasswordRoute = "ForgotPassword";
  static const String resetPasswordRoute = "ResetPassword";
  static const String signUpRoute = "SignUp";
  static const String homeRoute = "HomeScreen";
  static const String onboardingRoute = "OnboardingScreen";
  static const String splashScreenRoute = "SplashScreen";
  static const String authOptionScreenRoute = "AuthOptionScreen";
  static const String VerifyAccountScreenRoute = "VerifyAccountScreen";
  static const String pinSetupScreenRoute = "pinSetupScreen";
  static const String createNewPasswordScreenRoute = "createNewPasswordScreen";
  static const String createPasswordScreenRoute = "createPasswordScreen";
  static const String sentMailVerificationScreenRoute = "sentMailVerificationScreen";
  static const String otpScreenRoute = "OtpScreen";
  static const String IDScreenRoute = "IDScreen";
  static const String CreatePinScreenRoute = "CreatePinScreen";
  static const String DashboardPageRoute = "DashboardPage";
  static const String ConfirmationScreenRoute = "ConfirmationScreen";


  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const Homescreen(),
        );

      case onboardingRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.bottomToTop,
          routeName: settings.name!,
          viewToShow: const OnboardingView(),
        );
      case loginRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.bottomToTop,
          routeName: settings.name!,
          viewToShow: const LoginScreen(),
        );
      case splashScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.bottomToTop,
          routeName: settings.name!,
          viewToShow: const SplashScreen(),
        );


      case signUpRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const SignUpScreen(),
        );
      case VerifyAccountScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const ConfirmationScreen(),
        );
      case pinSetupScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const CreatePinScreen(),
        );
      case forgotPasswordRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const ConfirmationScreen(),
        );
      case createNewPasswordScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const CreateNewPassword(),
        );
      case sentMailVerificationScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const VerifyEmailScreen(),
        );
      case otpScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const OtpScreen(),
        );
      case sentMailVerificationScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.rightToLeft,
          routeName: settings.name!,
          viewToShow: const VerifyEmailScreen(),
        );
      case IDScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.bottomToTop,
          routeName: settings.name!,
          viewToShow: const IDScreen(),
        );
      case CreatePinScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.leftToRight,
          routeName: settings.name!,
          viewToShow: const CreatePinScreen(),
        );
      case DashboardPageRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.bottomToTop,
          routeName: settings.name!,
          viewToShow:  DashboardPage(),
        );
      case CreatePinScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.leftToRight,
          routeName: settings.name!,
          viewToShow: const CreatePinScreen(),
        );
      case ConfirmationScreenRoute:
        return _getTransitionPageRoute(
          type: PageTransitionType.leftToRight,
          routeName: settings.name!,
          viewToShow: const ConfirmationScreen(),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

  PageRoute _getPageRoute(
      {required String routeName, required Widget viewToShow}) {
    return MaterialPageRoute(
        settings: RouteSettings(
          name: routeName,
        ),
        builder: (_) => DialogManager(child: viewToShow));
  }

  PageRoute _getTransitionPageRoute({
    required String routeName,
    required Widget viewToShow,
    PageTransitionType type = PageTransitionType.bottomToTop,
  }) {
    return PageTransition(
        settings: RouteSettings(
          name: routeName,
        ),
        type: type,
        child: DialogManager(child: viewToShow));
  }
}
