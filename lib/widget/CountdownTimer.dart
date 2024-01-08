
import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final int countdown;

  const CountdownTimer({Key? key, required this.countdown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Time Left: ${countdown}s',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}