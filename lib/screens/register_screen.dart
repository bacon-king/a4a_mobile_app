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
          data: {
            'full_name': fullName,
            'username': username,
          },
        );

        if (response.user != null) {
          Fluttertoast.showToast(
            msg: 'Registration successful! Please check your email to confirm.',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          widget.onBack?.call();
        } else {
          throw Exception('Registration failed: No user returned');
        }
      } on AuthException catch (e) {
        String errorMsg = e.message;
        Fluttertoast.showToast(
          msg: errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        debugPrint('AuthException: $errorMsg');
      } catch (e) {
        String errorMsg = 'An error occurred: $e';
        if (e.toString().contains('SocketException') ||
            e.toString().contains('Failed host lookup')) {
          errorMsg = 'Network error: Unable to connect to the server. Please check your internet connection.';
        }
        Fluttertoast.showToast(
          msg: errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background white container
            Positioned(
              left: 0,
              top: 196,
              child: Container(
                width: 412,
                height: 721,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Full Name field
                        TextFormField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'John Smith',
                          ),
                          validator: RequiredValidator(
                            errorText: 'Full name is required',
                          ).call,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '*Your name will not be disclosed to other users',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF5A5A5A),
                            letterSpacing: 0.15,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Username field
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'blue_hedgehog_2025',
                          ),
                          validator: RequiredValidator(
                            errorText: 'Username is required',
                          ).call,
                        ),
                        const SizedBox(height: 16),

                        // Email field
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'john_smith@gmail.com',
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Email is required'),
                            EmailValidator(errorText: 'Enter a valid email'),
                          ]).call,
                        ),
                        const SizedBox(height: 16),

                        // Password field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: '********',
                          ),
                          validator: RequiredValidator(
                            errorText: 'Password is required',
                          ).call,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password field
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: '********',
                          ),
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        // Register button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleRegister, // Disable button during loading
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : const Text('REGISTER'),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Login link
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                                letterSpacing: 0.014,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Already have an account?\n',
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: widget.onLogin,
                                    child: const Text(
                                      'LOG IN',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        letterSpacing: 0.014,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Back button
            Positioned(
              left: 18,
              top: 58,
              child: GestureDetector(
                onTap: widget.onBack,
                child: Row(
                  children: [
                    const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 31,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Back',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            // Title
            Positioned(
              left: 28,
              top: 108,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create your',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}