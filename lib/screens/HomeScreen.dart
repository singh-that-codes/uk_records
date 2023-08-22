import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myukapp/screens/dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _showLoginFailedSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login failed. Please try again.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<bool> _performGoogleLogin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      // Attempt to sign in with Google
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in with Firebase using the Google credentials
        final UserCredential authResult = await auth.signInWithCredential(credential);

        if (authResult.user != null) {
          // Google login successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
          return true;
        }
      }
    } catch (error) {
      print("Google login error: $error");
    }

    // Google login failed
    _showLoginFailedSnackBar(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uttarakhand STF'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/police_logo.png',
                width: 150.0, // Adjust the size as needed
              ),
              SizedBox(height: 20.0),
              Text(
                'CRIMINAL RECORDS',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  bool loginSuccess = await _performGoogleLogin(context);
                  if (loginSuccess) {
                    print('Google login successful');
                  }
                },
                child: Text('Login with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
