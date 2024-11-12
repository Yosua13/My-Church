import 'package:flutter/material.dart';

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
                Color(0xFFE7C8EC),
                Color(0xFFDBADE3),
                Color(0xFFD8A9E0),
                Color(0xFFCE9DD6),
                Color(0xFFCE9DD6),
                Color(0xFFC391CB),
                Color(0xFFC391CB),
                Color(0xFFBA86C3),
                Color(0xFFB580BE),
                Color(0xFFAF77B8),
                Color(0xFFA366AD),
                Color(0xFF9654A1),
                Color(0xFF8D4698),
                Color(0xFF83378F),
                Color(0xFF782885),
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
          child: Stack(
            children: [
              const Positioned(
                top: 150,
                left: 50,
                right: 50,
                child: Text(
                  'Yosua Plant',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Fontserrat',
                      color: Color(0xFF028A04)),
                ),
              ),
              const Positioned(
                top: 200,
                right: 50,
                child: Text(
                  'Plant Net',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Fontserrat',
                      color: Color(0xFF028A04)),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/plant.png',
                  
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Login button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Registration button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Registration',
                      style: TextStyle(fontSize: 18),
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
