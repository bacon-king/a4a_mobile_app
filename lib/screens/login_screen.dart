import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../widgets/navigation.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRegister;
  final VoidCallback? onLoginSuccess;

  const LoginScreen({
    super.key,
    this.onBack,
    this.onRegister,
    this.onLoginSuccess,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Mock login success
      Fluttertoast.showToast(
        msg: 'Login successful!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      widget.onLoginSuccess?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.onSurface,
              onPressed: widget.onBack,
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            final horizontalPadding = screenWidth * 0.07; // 7% side padding
            final contentRadius = screenWidth * 0.11; // rounded top corners
            final sectionGap = screenHeight * 0.02; // vertical gaps
            screenHeight * 0.18; // where white panel starts
            final buttonHeight = 50.0; // keep comfortable touch target

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log into your Account',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // White content panel
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(contentRadius),
                        topRight: Radius.circular(contentRadius),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(horizontalPadding * 0.9),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: sectionGap),

                            // Email field
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email Address',
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                  errorText: 'Email is required',
                                ),
                                EmailValidator(
                                  errorText: 'Enter a valid email',
                                ),
                              ]).call,
                            ),
                            SizedBox(height: sectionGap),

                            // Password field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              validator: RequiredValidator(
                                errorText: 'Password is required',
                              ).call,
                            ),
                            SizedBox(height: screenHeight * .30),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: buttonHeight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  shadowColor: Theme.of(
                                    context,
                                  ).colorScheme.shadow,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: /*_handleLogin*/ () {
                                  bool loginSuccess = true;

                                  if (loginSuccess) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainNavigation(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('LOG IN'),
                              ),
                            ),
                            SizedBox(height: sectionGap),

                            // Login link
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: sectionGap),
                                  Text(
                                    "Don't have an account?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                  ),
                                  TextButton.icon(
                                    onPressed: widget.onRegister,
                                    icon: const Icon(Icons.person),
                                    label: const Text('Register'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
