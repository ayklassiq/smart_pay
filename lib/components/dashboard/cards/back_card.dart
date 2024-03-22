import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
  final String cvvCode;

  CardBack({
    Key? key,
    this.cvvCode = '***',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black87, // Card back color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Magnetic strip imitation
          Container(
            height: 50,
            color: Colors.grey[800],
            margin: EdgeInsets.only(top: 10, bottom: 20),
          ),
          // Signature panel
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.white,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  cvvCode, // Display the CVV code (masked)
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // Hint text for CVV
          Text(
            'CVV',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
