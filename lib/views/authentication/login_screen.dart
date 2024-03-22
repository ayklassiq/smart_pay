import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/components/buttons/full_button.dart';
import 'package:smart_pay/components/general_textfield.dart';
import 'package:smart_pay/helpers/colors.dart';
import 'package:smart_pay/helpers/regex.dart';
import 'package:smart_pay/helpers/routes.dart';
import 'package:smart_pay/helpers/size_calculator.dart';
import 'package:smart_pay/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  bool obscurePassword = true;

  final _formKeyEmail = GlobalKey<FormState>();
  String? _email;

  bool get areFieldsNotEmpty {
    return emailRegExMatch(emailEditingController.text) &&
        passwordEditingController.text.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: sizer(true, 16, context),
                  right: sizer(true, 16, context),
                  top: sizer(true, 15, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const AuthenticationHeader(),
                  InkWell(
                    child: Image.asset(
                      'assets/icons/back.png',
                      height: 40,
                      width: 40, // Adjust the height as needed
                    ),
                    onTap: () {
                      // Call Navigator.pop() to go back to the previous screen
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: sizer(false, 15, context),
                  ),
                  Text(
                    "Hi There! 👋",
                    style: TextStyle(
                        fontSize: sizer(true, 24, context),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFProDisplay',
                        color: AppColors.primary),
                  ),
                  Text(
                    "Welcome back, Sign in to your account",
                    style: TextStyle(
                        fontSize: sizer(true, 16, context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGrey),
                  ),
                  SizedBox(
                    height: sizer(false, 28, context),
                  ),
                  GeneralTextField(
                    key: _formKeyEmail,
                    focusNode: emailFocusNode,
                    textController: emailEditingController,
                    hintText: 'Email',
                    fontSize: sizer(true, 16, context),
                    keyboardType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: emailVal,
                    onChanged: (val) => setState(() {
                      _email = val;
                    }),
                  ),
                  SizedBox(
                    height: sizer(false, 10, context),
                  ),
                  GeneralTextField(
                    // key: _formKeyEmail,
                    obscureText: obscurePassword,
                    textController: passwordEditingController,
                    hintText: 'Password',
                    fontSize: sizer(true, 16, context),
                    keyboardType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: passwordVal,
                    onChanged: (val) => setState(() {
                      _email = val;
                    }),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: sizer(true, 24, context),
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: sizer(false, 13, context),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteHelper.forgotPasswordRoute);
                        },
                        child: Text('Forgot Password?',
                            style: TextStyle(
                                fontSize: sizer(true, 16, context),
                                color: AppColors.greenColor10,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: sizer(false, 23, context),
                  ),

                  FullButton(
                      buttonFunction: () {
                        print('thoi idniijidjjidjd');
                        if (areFieldsNotEmpty) {
                          print('thoi idniijidjjidjd');
                          authProvider.login(emailEditingController.text,
                              passwordEditingController.text, context);
                          Navigator.pushNamed(
                              context, RouteHelper.DashboardPageRoute);
                        }
                      },
                      buttonText: 'Sign In',
                      online: areFieldsNotEmpty),
                  SizedBox(
                    height: sizer(false, 20, context),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: sizer(false, 10, context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          color: AppColors.greyDividerColor,
                          width: MediaQuery.of(context).size.width * 0.34,
                        ),
                        SizedBox(
                          width: sizer(true, 16, context),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                              fontSize: sizer(true, 16, context),
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGrey),
                        ),
                        SizedBox(
                          width: sizer(true, 16, context),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.34,
                          color: AppColors.greyDividerColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/google.png',
                          // width: 48, // Adjust the width as needed
                          // height: 48, // Adjust the height as needed
                        ),
                        SizedBox(
                          width: sizer(true, 16, context),
                        ),
                        Image.asset(
                          'assets/icons/apple.png',
                          // width: 48, // Adjust the width as needed
                          // height: 48, // Adjust the height as needed
                        ),
                        SizedBox(
                          width: sizer(true, 16, context),
                        ),
                        SizedBox(
                          height: sizer(false, 110, context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizer(false, 125, context),
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                fontSize: sizer(true, 16, context),
                                fontWeight: FontWeight.w400,
                                color: AppColors.textGrey),
                            children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                                fontSize: sizer(true, 16, context),
                                fontFamily: 'SPFProDisplay',
                                fontWeight: FontWeight.w600,
                                color: AppColors.greenColor10),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(RouteHelper.signUpRoute);
                              },
                          )
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
