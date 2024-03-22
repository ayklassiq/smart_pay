import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/components/buttons/full_button.dart';
import 'package:smart_pay/providers/user_provider.dart';


import '../../components/general_textfield.dart';
import '../../helpers/colors.dart';
import '../../helpers/regex.dart';
import '../../helpers/routes.dart';
import '../../helpers/size_calculator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailEditingController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  final _formKeyEmail = GlobalKey<FormState>();
  String? _email;
  bool _isloading = false;

  bool get areFieldsNotEmpty {
    return emailRegExMatch(emailEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<UserProvider>(context, listen: false);
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
                  top: sizer(true, 40, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
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
                    height: sizer(false, 10, context),
                  ),
                  Row(
                    children: [
                      Text(
                        "Create a ",
                        style: TextStyle(
                            fontSize: sizer(true, 24, context),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary),
                      ),
                      Text(
                        "Smartpay",
                        style: TextStyle(
                            fontSize: sizer(true, 24, context),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0A6375)),
                      ),
                    ],
                  ),

                  Text(
                    "account",
                    style: TextStyle(
                        fontSize: sizer(true, 24, context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1),
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
                    height: sizer(false, 20, context),
                  ),
                  FullButton(
                      buttonFunction: () async {
                        setState(() {
                          _isloading = true;
                        });

                        // Attempt to register with the provided email
                        bool emailRegistered =
                            await emailProvider.signUpWithEmail(
                                emailEditingController.text, context);
                        print('this is the email outside: $emailRegistered');

                        // If fields are not empty and email is registered successfully, navigate to the next screen
                        if (areFieldsNotEmpty && emailRegistered) {
                          print('this is the email: $emailRegistered');
                          setState(() {
                            _isloading = false;
                          });
                          emailProvider.setEmail(emailEditingController.text);

                          Navigator.pushNamed(
                              context, RouteHelper.otpScreenRoute);
                        } else {
                          // If registration fails, show a dialog
                          setState(() {
                            _isloading = false;
                          });
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Login Failed'),
                              content: Text(
                                  'Please check your credentials and try again.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      buttonText: 'Sign Up',
                      isloading: _isloading,
                      online: areFieldsNotEmpty),
                  SizedBox(
                    height: sizer(false, 20, context),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: sizer(false, 16, context),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: sizer(false, 10, context)),
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
                                color: AppColors.primary),
                          ),
                          SizedBox(
                            width: sizer(true, 16, context),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: AppColors.greyDividerColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: sizer(false, 16, context),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: sizer(false, 10, context)),
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
                            height: sizer(false, 136, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: sizer(true, 16, context),
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ), // Default text style
                        children: <TextSpan>[
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: sizer(true, 14, context),
                              fontWeight: FontWeight.w400,
                              color: AppColors.text1,
                            ),
                          ),
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                              fontSize: sizer(true, 14, context),
                              fontWeight: FontWeight.w500,
                              color: AppColors.blueColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(RouteHelper.loginRoute);
                                // Your sign-in logic or navigation here
                              },
                          ),
                        ],
                      ),
                    ),
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
