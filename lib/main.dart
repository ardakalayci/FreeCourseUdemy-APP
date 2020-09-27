import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freecoursediscount/ui/splash_screen.dart';

Future<void> main() async {
  runApp(MyApp());
  await Firebase.initializeApp();

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Free Course Udemy Discount',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:Splash(),
    );
  }
}


