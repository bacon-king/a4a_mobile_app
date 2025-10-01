import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Added import for Supabase Flutter package

class RegisterScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onLogin;

  const RegisterScreen({super.key, this.onBack, this.onLogin});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false; // Manage loading state

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // This function handles the registration process using Supabase authentication.
  // It validates the form, attempts to sign up the user with email/password,
  // and stores full name and username in user_metadata.
  // Note: This assumes Supabase has been initialized elsewhere (e.g., in main.dart) with:
  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',  // Placeholder: Replace with your Supabase project URL (e.g., https://yourproject.supabase.co)
  //   anonKey: 'YOUR_ANON_KEY',  // Placeholder: Replace with your Supabase anon key
  // );
  // Users are saved in Supabase's auth.users table with UUIDs, and additional data in user_metadata.
  // Note: Without a separate profiles table, username uniqueness is not enforced.
  Future<void> _handleRegister() async {
    if (_isLoading) return; // Prevent multiple clicks

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading state
      });

      final supabase = Supabase.instance.client;
      final fullName = _fullNameController.text.trim();
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      try {
        // Proceed with signUp; stores data in user_metadata
        final response = await supabase.auth.signUp(
          email: email,
          password: password,
          data: {'full_name': fullName, 'username': username},
        );

        if (response.user != null) {
          Fluttertoast.showToast(
            msg: 'Registration successful! Please check your email to confirm.',
            toastLength: Toast.LENGTH_SHORT,
          );
          widget.onBack?.call();
        } else {
          throw Exception('Registration failed: No user returned');
        }
      } on AuthException catch (e) {
        String errorMsg = e.message;
        Fluttertoast.showToast(msg: errorMsg, toastLength: Toast.LENGTH_SHORT);
        debugPrint('AuthException: $errorMsg');
      } catch (e) {
        String errorMsg = 'An error occurred: $e';
        if (e.toString().contains('SocketException') ||
            e.toString().contains('Failed host lookup')) {
          errorMsg =
              'Network error: Unable to connect to the server. Please check your internet connection.';
        }
        Fluttertoast.showToast(msg: errorMsg, toastLength: Toast.LENGTH_SHORT);
        debugPrint('Error during registration: $e');
      } finally {
        setState(() {
          _isLoading = false; // Reset loading state
        });
      }
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
                          'Create your Account',
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

                            // Full Name field
                            TextFormField(
                              controller: _fullNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Full Name',
                                helperText: '*Your name will not be disclosed',
                              ),
                              validator: RequiredValidator(
                                errorText: 'Full name is required',
                              ).call,
                            ),
                            SizedBox(height: sectionGap),

                            // Username field
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              validator: RequiredValidator(
                                errorText: 'Username is required',
                              ).call,
                            ),
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
                            SizedBox(height: sectionGap),

                            // Confirm Password field
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Password',
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: sectionGap * 2),

                            // Register button
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
                                onPressed: _isLoading ? null : _handleRegister,
                                child: _isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('REGISTER'),
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
                                    'Already have an account?',
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
                                    onPressed: widget.onLogin,
                                    icon: const Icon(Icons.person),
                                    label: const Text('LOG IN'),
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
