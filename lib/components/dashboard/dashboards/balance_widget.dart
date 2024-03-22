import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final double balance;

  const BalanceWidget({Key? key, this.balance = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Balance',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            '\$$balance',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
