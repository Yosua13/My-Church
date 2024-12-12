import 'package:flutter/material.dart';
import 'package:proyek_akhir/routes/login_page.dart';
import 'package:proyek_akhir/routes/register_page.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFE082), // Amber lightest
                Color(0xFFFFD54F),
                Color(0xFFFFCA28),
                Color(0xFFFFC107),
                Color(0xFFFFB300),
                Color(0xFFFFA000),
                Color(0xFFFF8F00),
                Color(0xFFFF6F00),
                Color(0xFFF57C00),
                Color(0xFFEF6C00),
                Color(0xFFE65100),
                Color(0xFFDD4B00),
                Color(0xFFD84315),
                Color(0xFFBF360C), // Darker amber tone
                Color(0xFFB71C1C), // Darkest amber shade close to a burnt amber
              ],
              stops: [
                0.02,
                0.07,
                0.14,
                0.21,
                0.29,
                0.36,
                0.43,
                0.47,
                0.50,
                0.57,
                0.64,
                0.71,
                0.79,
                0.86,
                1.0,
              ],
            ),
          ),
          // child: Stack(
          //   children: [
          //     const Positioned(
          //       top: 150,
          //       left: 50,
          //       right: 50,
          //       child: Text(
          //         'My Church',
          //         style: TextStyle(
          //             fontSize: 40,
          //             fontWeight: FontWeight.w700,
          //             fontFamily: 'Fontserrat',
          //             color: Color(0xFF028A04)),
          //       ),
          //     ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'My Church',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Fontserrat',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE082),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE082),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
