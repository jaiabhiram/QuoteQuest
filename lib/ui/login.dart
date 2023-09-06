import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/auth/google_sign_in.dart';
import 'package:quotes/ui/home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Quotes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(
          height: 25,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Text('Sign In with google')),
        )
      ],
    ));
  }
}
