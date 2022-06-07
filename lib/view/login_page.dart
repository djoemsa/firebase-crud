import 'package:coders_meme/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        providerConfigs: [
          EmailProviderConfiguration(),
        ],
        headerBuilder: (context, constraint, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Coder's meme",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        footerBuilder: (context, _) {
          return Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  FireBaseServices().guestSignIn();
                },
                child: Text(
                  "Wanna see what's inside first? guest login",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
