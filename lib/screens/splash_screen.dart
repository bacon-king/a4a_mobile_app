import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback? onRegister;
  final VoidCallback? onLogin;

  const SplashScreen({super.key, this.onRegister, this.onLogin});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final imageSize = screenWidth * 0.7;
    final horizontalPadding = screenWidth * 0.1;
    final buttonWidth = screenWidth - (horizontalPadding * 2);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              SizedBox(
                width: imageSize,
                height: imageSize,
                child: const Center(child: Text('Splash Art')),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Hello.',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to A4A, your companion in your journey to good health.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.08),
              SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shadowColor: Theme.of(context).colorScheme.shadow,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onLogin,
                  child: const Text('LOG IN'),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: buttonWidth,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    backgroundColor: Colors.transparent, // usually transparent
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: onRegister,
                  child: const Text('REGISTER'),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
