import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomeFeedScreen extends StatelessWidget {
  final Function(String)? onNavigate;

  const HomeFeedScreen({super.key, this.onNavigate});

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
              top: 155,
              child: Container(
                width: 412,
                height: 762,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Article 1
                      _buildArticleCard(
                        title: 'Article Title',
                        source: 'Source Name',
                        imageUrl:
                            'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400',
                      ),

                      const SizedBox(height: 20),

                      // Article 2
                      _buildArticleCard(
                        title: 'Article Title',
                        source: 'Source Name',
                        imageUrl:
                            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Title
            Positioned(
              left: 28,
              top: 108,
              child: Text(
                'Your Feed',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
            ),

            // Bottom Navigation
            Positioned(
              left: 0,
              top: 804,
              child: CustomBottomNavigationBar(
                currentIndex: 0,
                onNavigate: onNavigate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String source,
    required String imageUrl,
  }) {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),

          // Content
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    source,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      letterSpacing: 0.024,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
