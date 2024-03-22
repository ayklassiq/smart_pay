import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/components/buttons/next_button.dart';
import 'package:smart_pay/providers/user_provider.dart';

import '../../components/general_textfield.dart';
import '../../helpers/colors.dart';
import '../../helpers/regex.dart';
import '../../helpers/routes.dart';
import '../../helpers/size_calculator.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  TextEditingController emailEditingController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  final _formKeyEmail = GlobalKey<FormState>();
  String? _email;

  bool get areFieldsNotEmpty {
    return emailRegExMatch(emailEditingController.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    print('the vaule for are token is ${authProvider.token}');
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
                  top: sizer(true, 60, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const AuthenticationHeader(),
                  Image.asset(
                    'assets/icons/lock.png', // Adjust the height as needed
                  ),
                  SizedBox(
                    height: sizer(false, 10, context),
                  ),
                  Text(
                    "Passsword Recovery",
                    style: TextStyle(
                        fontSize: sizer(true, 24, context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                  ),
                  Text(
                    "Enter your registered email below to receive password instructions",
                    style: TextStyle(
                        fontSize: sizer(true, 14, context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.text1),
                  ),
                  SizedBox(
                    height: sizer(false, 10, context),
                  ),
                  GeneralTextField(
                    key: _formKeyEmail,
                    focusNode: emailFocusNode,
                    textController: emailEditingController,
                    hintText: 'Enter your email address',
                    keyboardType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: emailVal,
                    onChanged: (val) => setState(() {
                      _email = val;
                    }),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.38,
                  ),
                  FullButton(
                      buttonFunction: () {
                        areFieldsNotEmpty == true
                            ? Navigator.pushNamed(context,
                                RouteHelper.sentMailVerificationScreenRoute)
                            : () {};
                      },
                      buttonText: 'Send me email',
                      online: areFieldsNotEmpty),
                  SizedBox(
                    height: sizer(false, 20, context),
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
