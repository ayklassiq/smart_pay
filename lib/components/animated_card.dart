import 'package:flutter/material.dart';

class AnimatedCreditCard extends StatefulWidget {
  @override
  _AnimatedCreditCardState createState() => _AnimatedCreditCardState();
}

class _AnimatedCreditCardState extends State<AnimatedCreditCard> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller!.forward();
        }
      });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(3.14 * _flipAnimation!.value),
      child: Container(
        width: 300,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: _flipAnimation!.value < 0.5
            ? Center(
                child: Text(
                  'Credit Card Front',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(3.14),
                child: Center(
                  child: Text(
                    'Credit Card Back',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
      ),
    );
  }
}
