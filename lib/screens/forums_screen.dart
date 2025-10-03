import 'package:flutter/material.dart';

class ForumsScreen extends StatelessWidget {
  final Function(String)? onNavigate;

  const ForumsScreen({super.key, this.onNavigate});

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

                      // Forum Post 1
                      _buildForumPost(
                        title: 'Forum Title',
                        content:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
                        username: 'username',
                      ),

                      const SizedBox(height: 20),

                      // Forum Post 2
                      _buildForumPost(
                        title: 'Forum Title',
                        content:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
                        username: 'username',
                      ),

                      const SizedBox(height: 20),

                      // Forum Post 3
                      _buildForumPost(
                        title: 'Forum Title',
                        content:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore...',
                        username: 'username',
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
                'Forums',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForumPost({
    required String title,
    required String content,
    required String username,
  }) {
    return Container(
      width: double.infinity,
      height: 202,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info
            Row(
              children: [
                const CircleAvatar(
                  radius: 12.5,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    letterSpacing: 0.027,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Content
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  letterSpacing: 0.027,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Action buttons
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_outlined, size: 24),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.reply_outlined, size: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
