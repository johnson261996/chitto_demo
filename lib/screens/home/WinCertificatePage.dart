import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/UserProvider.dart';
import '../../widget/CountdownTimer.dart';

class CertificatePage extends StatefulWidget {
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  bool canSubmit = true;
   int countdown = 30;
  TextEditingController answerController = TextEditingController();

   @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Win Certificate'),
        actions: [
          CountdownTimer(countdown: countdown),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tell me about yourself?',style: TextStyle(fontSize: 15),),
            SizedBox(height: 10),
            Consumer<UserProvider>(
              builder: (context, userProvider, _) => TextField(
                controller: answerController,
                enabled: canSubmit,
                onChanged: (text) => userProvider.setAnswer(text),
                decoration: InputDecoration(
                  hintText: 'Your answer...',
                ),
              ),
            ),
            
            SizedBox(height: 20),
            if(!canSubmit)
            ElevatedButton(
              onPressed: canSubmit ? null : submitAnswer,
              child: Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          canSubmit = false;
          timer.cancel();
        }
      });
    });
  }

  void submitAnswer() {
    // TODO: Implement answer submission logic
    // You can access the answer using answerController.text
  }
}