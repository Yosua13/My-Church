import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_akhir_dicoding/provider/favorite_churches_provider.dart';
import 'package:proyek_akhir_dicoding/provider/user_provider.dart';
import 'package:proyek_akhir_dicoding/routes/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteChurchesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
