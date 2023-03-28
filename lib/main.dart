import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_azinova/screens/home_screen.dart';
import 'package:machine_test_azinova/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Azinova Machine Test',
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
              home: const HomeScreen(),
            ));
  }
}
