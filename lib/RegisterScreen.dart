import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFF000000),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: IntrinsicHeight(
                            child: Container(
                              padding: const EdgeInsets.only(right: 3),
                              margin: const EdgeInsets.only(
                                top: 58,
                                bottom: 19,
                                left: 18,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 31,
                                    height: 31,
                                    child: Image.network(
                                      'https://storage.googleapis.com/tagjs-prod.appspot.com/v1/o6lX0ppLfx/pclpznu7_expires_30_days.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const Text(
                                    'Back',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8, left: 28),
                          width: 177,
                          child: const Text(
                            'Create your\nAccount',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                              ),
                              color: Color(0xFFFFFFFF),
                            ),
                            padding: const EdgeInsets.only(top: 60, bottom: 72),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicWidth(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                        left: 29,
                                      ),
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Full Name',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF5A5A5A),
                                        width: 1,
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                      left: 12,
                                      right: 12,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: 8,
                                      left: 29,
                                      right: 29,
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IntrinsicWidth(
                                          child: IntrinsicHeight(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 2,
                                                  ),
                                              child: const Column(
                                                children: [
                                                  Text(
                                                    'John Smith',
                                                    style: TextStyle(
                                                      color: Color(0xFF5A5A5A),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 19,
                                          height: 19,
                                          child: Image.network(
                                            'https://storage.googleapis.com/tagjs-prod.appspot.com/v1/o6lX0ppLfx/xshzlsym_expires_30_days.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IntrinsicWidth(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 2),
                                      margin: const EdgeInsets.only(
                                        bottom: 25,
                                        left: 29,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 4,
                                            ),
                                            width: 12,
                                            height: 12,
                                            child: Image.network(
                                              'https://storage.googleapis.com/tagjs-prod.appspot.com/v1/o6lX0ppLfx/siam14te_expires_30_days.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Text(
                                            '*Your name will not be disclosed to other users',
                                            style: TextStyle(
                                              color: Color(0xFF5A5A5A),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicWidth(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                        left: 29,
                                      ),
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Username',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF5A5A5A),
                                        width: 1,
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 12,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: 25,
                                      left: 29,
                                      right: 29,
                                    ),
                                    width: double.infinity,
                                    child: const Column(
                                      children: [
                                        Text(
                                          'blue_hedgehog_2025',
                                          style: TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IntrinsicWidth(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                        left: 28,
                                      ),
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Email Address',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF5A5A5A),
                                        width: 1,
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 12,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: 25,
                                      left: 28,
                                      right: 28,
                                    ),
                                    width: double.infinity,
                                    child: const Column(
                                      children: [
                                        Text(
                                          'john_smith@gmail.com',
                                          style: TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IntrinsicWidth(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                        left: 29,
                                      ),
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Password',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF5A5A5A),
                                        width: 1,
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 12,
                                      right: 27,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: 25,
                                      left: 29,
                                      right: 29,
                                    ),
                                    width: double.infinity,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '********',
                                          style: TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IntrinsicWidth(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                        left: 28,
                                      ),
                                      child: const Column(
                                        children: [
                                          Text(
                                            'Confirm Password',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF5A5A5A),
                                        width: 1,
                                      ),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 12,
                                      right: 27,
                                    ),
                                    margin: const EdgeInsets.only(
                                      bottom: 44,
                                      left: 28,
                                      right: 28,
                                    ),
                                    width: double.infinity,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '********',
                                          style: TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print('Pressed');
                                  },
                                  child: IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: const Color(0xFF000000),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 17,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 31,
                                        left: 29,
                                        right: 29,
                                      ),
                                      width: double.infinity,
                                      child: const Column(
                                        children: [
                                          Text(
                                            'REGISTER',
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 158,
                                          child: const Text(
                                            'Already have an account?LOG IN',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
