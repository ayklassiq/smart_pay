import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;

  CreditCardWidget({
    Key? key,
    this.cardNumber = '**** **** **** ****',
    this.cardHolderName = 'CARD HOLDER',
    this.expiryDate = 'MM/YY',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF114357), Color(0xFFF29492)], // Example gradient colors
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.credit_card,
                size: 24,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Text(
              'VISA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Brand-Bold', // Customize with your font
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              cardNumber, // Use passed card number
              style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2.0),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              cardHolderName, // Use passed card holder name
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              expiryDate, // Use passed expiry date
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
