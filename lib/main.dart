import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:fyp/user/fragments/dashboard_of_fragments.dart';
import 'package:fyp/user/login_screen.dart';
import 'package:fyp/user/userPreferences/user_preferences.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot)
        {
          if (dataSnapShot.data == null)
          {
            return LoginScreen();
          }
          else
          {
            return DashboardOfFragments();
          }
        },
      ),
    );
  }
}