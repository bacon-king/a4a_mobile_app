import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const FaqScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    const navBarHeight = 76.0;
    const double contentTop = 190.0; // add a bit of space below the title

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background white container with top rounded corners
            Positioned(
              left: 0,
              top: contentTop,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height:
                    screenHeight - contentTop - navBarHeight - safeAreaBottom,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 8),
                      _FaqCard(
                        title: 'What is A4A?',
                        body:
                            'A4A (Aid for AIDS) is a mobile application designed to support people living with HIV (PLHIV) in the Philippines. It helps users manage treatment schedules, track moods and symptoms, receive AI-powered health tips, and connect through an anonymous forum.',
                      ),
                      SizedBox(height: 20),
                      _FaqCard(
                        title: 'Who can use A4A?',
                        body:
                            'The app is primarily for PLHIV who want discreet and reliable support in managing their health. However, healthcare providers, researchers, and advocates may also find it useful for understanding digital health support.',
                      ),
                      SizedBox(height: 20),
                      _FaqCard(
                        title: 'What features does A4A offer?',
                        body:
                            'A4A provides a range of features designed to support people living with HIV. It includes medication and appointment reminders to help users stay on track with their treatment schedules. Users can also log and monitor their moods and symptoms to gain insights into their overall well-being. The app offers a personalized health feed, which delivers relevant health tips and motivational content based on the user’s activity. In addition, A4A hosts an anonymous forum where users can connect with others, share experiences, and provide support without revealing their identity. Finally, the profile and settings section allows users to manage their preferences, notifications, and privacy options.',
                      ),
                      SizedBox(height: 20),
                      _FaqCard(
                        title: 'Is my data safe?',
                        body:
                            'Yes. A4A encrypts all sensitive information, follows the Philippine Data Privacy Act, and anonymizes all forum interactions.',
                      ),
                      SizedBox(height: 20),
                      _FaqCard(
                        title: 'Will A4A be available on iOS in the future?',
                        body:
                            'Currently, A4A is only for Android. However, future versions may expand.',
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),

            // Back button
            Positioned(
              left: 18,
              top: 58,
              child: GestureDetector(
                onTap: onBack,
                child: Row(
                  children: const [
                    SizedBox(
                      width: 31,
                      height: 31,
                      child: Icon(Icons.chevron_left,
                          color: Colors.white, size: 24),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

            // Title
            const Positioned(
              left: 28,
              top: 108,
              child: SizedBox(
                width: 300,
                child: Text(
                  'Frequently Asked\nQuestions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqCard extends StatelessWidget {
  final String title;
  final String body;

  const _FaqCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              height: 1.4,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
