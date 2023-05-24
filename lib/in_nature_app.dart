

import 'package:flutter/material.dart';

import 'ui/home/home_page.dart';

class InNatureApp extends StatelessWidget {
  const InNatureApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Nature Sounds",
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      home: const HomePage(),
    );
  }
}