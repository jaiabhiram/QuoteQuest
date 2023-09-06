import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/auth/google_sign_in.dart';

class Accounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _accountsState();
}

class _accountsState extends State<Accounts> {
  var currentUser = FirebaseAuth.instance.currentUser;
  var name = '', photoUrl = '', email = '';

  void getUserInfo() {
    if (currentUser != null) {
      var _name = currentUser!.displayName;
      var _photoUrl = currentUser!.photoURL;
      var _email = currentUser!.email;
      setState(() {
        name = _name!;
        photoUrl = _photoUrl!;
        email = _email!;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Image.network(photoUrl)),
        Expanded(
            child: Column(
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              email,
            ),
          ],
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            child: Text('Logout'),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
