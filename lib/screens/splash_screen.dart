import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback? onRegister;
  final VoidCallback? onLogin;

  const SplashScreen({super.key, this.onRegister, this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image placeholder
            Positioned(
              left: 59,
              top: 131,
              child: Container(
                width: 294,
                height: 294,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Center(
                  child: Text(
                    'Splash Art',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      letterSpacing: 0.027,
                    ),
                  ),
                ),
              ),
            ),

            // Welcome text
            Align(
              alignment: Alignment(0, 0.45), // Adjust vertical position as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hello.',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to A4A, your companion in',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                  ),
                  Text(
                    'your journey to good health.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),

            // Login button
            Positioned(
              left: 45,
              top: 667,
              child: SizedBox(
                width: 321,
                height: 50,
                child: ElevatedButton(
                  onPressed: onLogin,
                  child: const Text('LOG IN'),
                ),
              ),
            ),

            // Register button
            Positioned(
              left: 45,
              top: 737,
              child: SizedBox(
                width: 321,
                height: 50,
                child: OutlinedButton(
                  onPressed: onRegister,
                  child: const Text('REGISTER'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
