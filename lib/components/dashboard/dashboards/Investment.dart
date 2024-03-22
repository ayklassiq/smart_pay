
import 'package:flutter/material.dart';


class InvestmentInsightsWidget extends StatelessWidget {
  final String secretMessage;

  const InvestmentInsightsWidget({super.key, required this.secretMessage});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Investment Insights',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Here are some insights based on your recent investment activities.',
          ),

          SizedBox(height: 10),
          Text(
            'Screte Message: $secretMessage',
          ),
          // Add more content or visualization about investments here
        ],
      ),
    );
  }
}
