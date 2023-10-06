import 'package:flutter/material.dart';

import 'icon_maker_page.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icon Maker',
      theme: ThemeData.dark()
          .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const IconMakerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
