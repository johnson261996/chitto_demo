import 'package:flutter/material.dart';

import '../WinCertificatePage.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CertificatePage()),
            );
          },
          child: Text('Win Certificate'),
        ),
      ),
    );
  }
}