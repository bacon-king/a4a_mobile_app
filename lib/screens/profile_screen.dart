import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final Function(String)? onNavigate;

  const ProfileScreen({super.key, this.onNavigate});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
<<<<<<< HEAD
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final profileImageUrl = user?.userMetadata?['profile_image_url'];
  if (user != null) {
    // ...fetch logic...
    if (mounted) {
      setState(() {
        email = user.email ?? 'Unknown';
        username = user.userMetadata?['username'] ?? 'Unknown';
        isLoading = false;
      });
    }
  } else {
    if (mounted) {
      setState(() {
        email = 'Unknown';
        username = 'Unknown';
        isLoading = false;
      });
=======
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user != null) {
      // ...fetch logic...
      if (mounted) {
        setState(() {
          email = user.email ?? 'Unknown';
          username = user.userMetadata?['username'] ?? 'Unknown';
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          email = 'Unknown';
          username = 'Unknown';
          isLoading = false;
        });
      }
>>>>>>> 0fdd0ad9a038a4b24a22527ade98b9e8976c8724
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final navBarHeight = 76.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  // Background white container
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 155,
                    bottom: navBarHeight + safeAreaBottom,
                    child: Container(
<<<<<<< HEAD
=======
                      width: MediaQuery.of(context).size.width,
                      height:
                          screenHeight - 155 - navBarHeight - safeAreaBottom,
>>>>>>> 0fdd0ad9a038a4b24a22527ade98b9e8976c8724
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          28.0,
                          28.0,
                          28.0,
                          40.0,
                        ), // Reduced bottom padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
<<<<<<< HEAD
                            _buildProfileCard(), // Profile Card
                            const SizedBox(height: 32),
                            _buildGeneralSettingsSection(), // General Settings Section
                            const SizedBox(height: 32),
                            _buildPreferencesSection(), // Preferences Section
                            const SizedBox(height: 32),
                            _buildLogoutButton(), // Logout Button
=======

                            // Profile Card
                            _buildProfileCard(),

                            const SizedBox(height: 32),

                            // General Settings Section
                            _buildGeneralSettingsSection(),

                            const SizedBox(height: 32),

                            // Preferences Section
                            _buildPreferencesSection(),

                            const SizedBox(height: 32),

                            // Logout Button
                            _buildLogoutButton(),

>>>>>>> 0fdd0ad9a038a4b24a22527ade98b9e8976c8724
                            const SizedBox(height: 32),
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
                      'My Profile',
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

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.black),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username ?? 'Unknown User',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  email ?? 'Unknown Email',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'General Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _buildSettingsItem(
          icon: Icons.person_outline,
          title: 'Edit Profile',
          subtitle: 'Change profile picture, username, E-mail',
          onTap: () {
            widget.onNavigate?.call('edit_profile');
          },
        ),
        const SizedBox(height: 24),
        _buildSettingsItem(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update and strengthen account security',
          onTap: () {
            widget.onNavigate?.call('change_password');
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferences',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _buildNotificationItem(),
        const SizedBox(height: 24),
        _buildSettingsItem(
          icon: Icons.info_outline,
          title: 'FAQ',
          subtitle: 'Frequently Asked Questions',
          onTap: () {
            widget.onNavigate?.call('faq');
          },
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 24),

            const SizedBox(width: 19),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem() {
    return GestureDetector(
      onTap: () => widget.onNavigate?.call('change_notifications'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: const Row(
          children: [
            Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
            SizedBox(width: 19),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Customize notification preferences',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            // Handle logout
            Provider.of<AppStateProvider>(
              context,
              listen: false,
            ).navigateToScreen('login');
          },
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
