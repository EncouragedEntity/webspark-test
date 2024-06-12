import 'package:flutter/material.dart';

import 'src/presentation/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
