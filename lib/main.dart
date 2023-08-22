import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myukapp/firebase_options.dart';
import 'package:myukapp/screens/HomeScreen.dart';
import 'package:myukapp/screens/dashboard_screen.dart';
import 'package:myukapp/screens/list_screen.dart';
import 'package:myukapp/screens/sign_up_page.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Criminal History Data STF Uttarakhand",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/list': (context) => ListScreen(),
        '/dashboard': (context) =>DashboardScreen(),
      },
    );
  }
}
