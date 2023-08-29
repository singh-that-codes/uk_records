

// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myukapp/screens/dashboard_screen.dart';
import 'package:myukapp/styles/app_colors.dart';
import 'package:myukapp/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _showLoginFailedSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
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
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
          return true;
        }
      }
    } catch (error) {
      //print("Google login error: $error");
    }

    // Google login failed
    _showLoginFailedSnackBar(context);
    return false;
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'Uttarakhand STF',
          style:AppStyles.titleSty,
          ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(8.w, 30.h, 8.w, 0.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/police_logo.png',
                  width: 120.0.sp,
                ),
                SizedBox(height: 20.h),
                Text(
                  'CRIMINAL RECORDS',
                  style: AppStyles.headingStyle
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () async {
                    bool loginSuccess = await _performGoogleLogin(context);
                    if (loginSuccess) {
                      //print('Google login successful');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor, // Button background color
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 2.w,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 30.0.sp,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Login with Google',
                        style: AppStyles.bodyStyle.copyWith(
                          color: AppColors.textColor // Button text color
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}