
import 'package:chitto_demo/provider/UserProvider.dart';
import 'package:chitto_demo/screens/VerifyCodePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class AuthNotifier extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String phoneNumber = "";
  String smsCode = "";
  bool get authenticated => _auth.currentUser != null;
  late String verificationId;

  Future<void> generateOtp(BuildContext context) async {
  final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      verificationId = verId;
    };
    _navigateToVerificationPage(context);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          codeAutoRetrievalTimeout: (String verId) {
            verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
          },
          verificationFailed: (FirebaseAuthException  exception) {
            // Navigator.pop(context, exception.message);
          });
    } catch (e) {
      handleError(e as PlatformException);
      // Navigator.pop(context, (e as PlatformException).message);
    }
  }

  Future<void> verifyOtp( BuildContext context) async {
     if (smsCode == null || smsCode == '') {
      //showAlertDialog(context, 'please enter 6 digit otp');
      return;
    }
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final User? currentUser = await _auth.currentUser;
      assert(user.user?.uid == currentUser?.uid);
     // Navigator.pushReplacementNamed(context, '/homeScreen');
     navigateToMainPage(context);
    } catch (e) {
      handleError(e as PlatformException);
    }
  }

  void handleError(Exception exception) {
  if (exception is FirebaseAuthException) {
    // Handle specific Firebase Authentication exceptions
    print('Firebase Authentication Error: ${exception.code}, ${exception.message}');
    // You can provide user feedback or handle errors as needed
  } else if (exception is PlatformException) {
    // Handle general platform exceptions
    print('Platform Exception: ${exception.code}, ${exception.message}');
    // You can provide user feedback or handle errors as needed
  } else {
    // Handle other types of exceptions
    print('Unexpected Exception: ${exception.toString()}');
    // You can provide user feedback or handle errors as needed
  }
}

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
        navigateToMainPage(context);
        notifyListeners();
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> _navigateToVerificationPage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyCodePage(),
      ),
    );
  }

   void navigateToMainPage(BuildContext context) {
    // Navigate to the main page
    Navigator.pushReplacementNamed(context, '/main'); // Adjust route name accordingly
  }
}