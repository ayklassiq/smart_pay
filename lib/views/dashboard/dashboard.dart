



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/components/dashboard/cards/back_card.dart';
import 'package:smart_pay/components/dashboard/cards/front_card.dart';
import 'package:smart_pay/components/dashboard/dashboards/Investment.dart';
import 'package:smart_pay/components/dashboard/dashboards/balance_widget.dart';
import 'package:smart_pay/components/dashboard/dashboards/transaction_widget.dart';
import 'package:smart_pay/helpers/colors.dart';
import 'package:smart_pay/helpers/size_calculator.dart';
import 'package:smart_pay/providers/user_provider.dart';

import '../../helpers/routes.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;
  Animation<double>? _flipAnimation;
  String? secretMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_)async {
      final authProvider = Provider.of<UserProvider>(context, listen: false);
      authProvider.getDashboard(context);
    });
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController!.forward();
        }
      });

    _animationController!.forward();
  }



  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final user= authProvider.usermodel;
    final secreteMessage = authProvider.secret;


    return Scaffold(
      appBar: AppBar(
        title: Text('SmartPay Dashboard',

          style: TextStyle(
              fontSize: sizer(true, 20, context),
              fontWeight: FontWeight.w400,
              color: AppColors.white

          ),
        ),
        actions: [

          // log out button
          IconButton(
            icon: Icon(Icons.logout),
            color: AppColors.white,
            onPressed: ()async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var value = await authProvider.logout(context);
              if (value == true) {
                prefs.clear();
                Navigator.pushNamedAndRemoveUntil(context, RouteHelper.loginRoute, (route) => false);
                prefs.clear();



              }
              print('this is the call back value $value');
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation!,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      textAlign: TextAlign.start,
                      'Welcome, ${user.username ?? 'User'}!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            AnimatedCreditCard(flipAnimation: _flipAnimation),
            SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('Account Balance'),
                subtitle: Text('\$1,234.56'), // Placeholder for dynamic data
              ),
            ),
            // BalanceWidget(balance: 12345.67),
            RecentTransactionsWidget(transactions: [
              "Grocery Store - \$50.00",
              "Online Shopping - \$120.00",
              "Coffee Shop - \$5.75"
            ]),
            Container(
              child: InvestmentInsightsWidget(
                secretMessage: secreteMessage ?? 'No secret message available',
              ),
            ),
            // Your other dashboard content here
          ],
        ),
      ),
    );
  }
}


class AnimatedCreditCard extends StatelessWidget {
  final Animation<double>? flipAnimation;

  const AnimatedCreditCard({Key? key, this.flipAnimation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).usermodel;
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(3.14 * flipAnimation!.value),
        child: Container(
          width: 300,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: flipAnimation!.value < 0.5
              ?  CreditCardWidget(
            cardNumber: '1234 5678 9012 3456',
            cardHolderName: '${user.fullName ?? 'User'}',
            expiryDate: '08/24',
          )
              : Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(3.14),
            child: CardBack(
              cvvCode: '435', // Optional: Pass the CVV code if needed
            ),
          ),
        ),
      ),
    );
  }
}
