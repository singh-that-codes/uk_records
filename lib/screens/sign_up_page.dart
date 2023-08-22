import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
        // Successfully signed in with Google, you can navigate to a new screen or do other actions.
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _signInWithGoogle(context);
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/google.png'),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Sign Up with Google",
                    ),
                  ),
                ],
              ),
            ),
            // Add the "Sign Up with Email" section here
          ],
        ),
      ),
    );
  }
}
