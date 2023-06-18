import 'package:echo/home_screen.dart';
import 'package:echo/pallete.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Echo',
      theme: ThemeData(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
      home: const HomeScreen(),
    );
  }
}
