

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../provider/AuthNotifier.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
     var authNotifier = context.read<AuthNotifier>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the OTP sent to ${authNotifier.phoneNumber}'),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                selectedFillColor: Colors.transparent,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              controller: otpController,
              onChanged: (value) {
                // Handle OTP input change
                authNotifier.smsCode = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : () => _verifyOTP(authNotifier),
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOTP(AuthNotifier authNotifier) async {
    // Implement your OTP verification logic here
    // You can use the 'otpController.text' to get the entered OTP
    setState(() {
      isLoading = true;
    });

    // Example verification delay
    await Future.delayed(Duration(seconds: 2));
     await authNotifier.verifyOtp(context);
    // After verification, navigate to the next screen or perform necessary actions
    // For example, you can use Navigator.pop() to go back or push a new screen
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextScreen()));
    

    setState(() {
      isLoading = false;
    });
  }
}
