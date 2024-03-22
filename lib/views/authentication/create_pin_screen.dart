import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../../components/buttons/full_button.dart';
import '../../components/pin_textfield.dart';
import '../../helpers/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/routes.dart';
import '../../helpers/size_calculator.dart';

class CreatePinScreen extends StatefulWidget {
  final String? AppState;
  const CreatePinScreen({super.key, this.AppState = ''});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String _pin = '';
  TextEditingController pinEditingController = TextEditingController();
  //  SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    widget.AppState == 'resumed'
                        ? "PIN code"
                        : "Set your PIN code",
                    style: TextStyle(
                        fontSize: sizer(true, 24, context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                  ),
                  Text(
                    "We use state-of-the-art security measures to protect your information at all times",
                    style: TextStyle(
                        fontSize: sizer(true, 14, context),
                        fontWeight: FontWeight.w400,
                        color: AppColors.text1),
                  ),
                  SizedBox(
                    height: sizer(false, 32, context),
                  ),
                  Center(
                    child: PinCodeFields(
                      length: 5,
                      obscureText: true,
                      controller: pinEditingController,
                      obscureCharacter: "🔴",
                      onComplete: (String value) {
                        setState(() {
                          _pin = value ?? '';
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: sizer(false, 30, context),
                  ),

                  FullButton(
                    buttonFunction: () async {
                      print('create pin');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (widget.AppState == 'resumed') {
                        var storedPin = prefs.getString('pin');
                        if (storedPin == pinEditingController.text) {
                          // If the entered PIN is correct, navigate to the Dashboard
                          Navigator.pushNamed(
                              context, RouteHelper.DashboardPageRoute);
                        } else {
                          // If the entered PIN is incorrect, show an error dialog
                          return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Invalid PIN'),
                              content:
                                  Text('The PIN you entered is incorrect.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        // Check if the PIN length is 5 characters and save it
                        Navigator.pushNamed(
                            context, RouteHelper.ConfirmationScreenRoute);
                        if (pinEditingController.text.length == 5) {
                          // Save the PIN in SharedPreferences
                          await prefs.setString(
                              'pin', pinEditingController.text);

                          // Navigate to the Confirmation Screen
                          Navigator.pushNamed(
                              context, RouteHelper.ConfirmationScreenRoute);
                        } else {
                          // If the PIN length is not 5 characters, show an error dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Incomplete PIN'),
                              content: Text('Please enter a 5-digit PIN.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    buttonText:
                        widget.AppState == 'resumed' ? "Confirm" : "Create PIN",
                    online: pinEditingController.text.length == 5,
                  ),

                  FullButton(
                    buttonFunction: () {
                      Navigator.pushNamed(
                          context, RouteHelper.DashboardPageRoute);
                    },
                    buttonText: 'Skip',
                    online: true,
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
