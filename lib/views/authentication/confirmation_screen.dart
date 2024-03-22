import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/components/buttons/full_button.dart';
import 'package:smart_pay/helpers/routes.dart';
import 'package:smart_pay/helpers/size_calculator.dart';
import 'package:smart_pay/model/users_model.dart';
import 'package:smart_pay/providers/user_provider.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    UsersModel user = authProvider.usermodel;
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/icons/thumb.png',
            height: 200,
            width: 200,
          ),
          Text(
            'Congratulations, ${user.username ?? 'user'}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: sizer(true, 10, context),
          ),
          Text(
            "You've completed the onboarding, you now start using the app now!!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: sizer(true, 10, context),
          ),
          FullButton(
            buttonFunction: () {
              Navigator.pushNamed(context, RouteHelper.DashboardPageRoute);
            },
            buttonText: 'Get Started',
          ),
        ],
      ),
    );
  }
}
