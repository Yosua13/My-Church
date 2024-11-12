import 'package:flutter/material.dart';
import 'package:proyek_akhir_dicoding/routes/my_church_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const MyChurchApp(),
    );
  }
}
