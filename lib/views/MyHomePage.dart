import 'package:aclub/views/auth/splash.dart';
import 'package:aclub/views/home/myhome.dart';
import 'package:aclub/views/home/persistent_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




// Import your persistent navigation wrapper

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Ensure binding before Firebase initialization
  // await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ACLUB',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const PersistentBottomNavBar(), // Use the persistent navigation wrapper
        );
      },
    );
  }
}























