// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myukapp/firebase_options.dart';
import 'package:myukapp/screens/HomeScreen.dart';
import 'package:myukapp/screens/dashboard_screen.dart';
import 'package:myukapp/screens/list_screen.dart';
import 'package:myukapp/screens/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          title: "Criminal History Data STF Uttarakhand",
          theme: ThemeData(primarySwatch: Colors.red),
          debugShowCheckedModeBanner: false,
          initialRoute: '/homescreen', // Set the initial route directly
          routes: {
            '/homescreen': (context) => HomeScreen(),
            '/signup': (context) => SignUpScreen(),
            '/list': (context) => ListScreen(),
            '/dashboard': (context) => DashboardScreen(),
          },
        );
      },
    );
  }
}
