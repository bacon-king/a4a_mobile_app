import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
=======
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
>>>>>>> 0fdd0ad9a038a4b24a22527ade98b9e8976c8724

class EditProfileScreen extends StatefulWidget {
  final Function(String)? onNavigate;

  const EditProfileScreen({super.key, this.onNavigate});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _profileImageFile;
  String? _profileImageUrl;
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    _usernameController.text = user?.userMetadata?['username'] ?? '';
    _emailController.text = user?.email ?? '';
    _profileImageUrl = user?.userMetadata?['profile_image_url'];
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    const navBarHeight = 76.0;
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    final keyboardOpen = keyboardInset > 0;
    final effectiveNavBarHeight = keyboardOpen ? 0.0 : navBarHeight;

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
                width: MediaQuery.of(context).size.width,
                height:
                    screenHeight - 155 - effectiveNavBarHeight - safeAreaBottom,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    28.0,
                    28.0,
                    28.0,
                    70.0 + keyboardInset + 74.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildProfilePictureSection(), // Profile Picture Section
                      const SizedBox(height: 32),
                      _buildUsernameField(), // Username Field
                      const SizedBox(height: 25), 
                      _buildEmailField(), // Email Field
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // Back Button
            Positioned(
              left: 18,
              top: 58,
              child: GestureDetector(
                onTap: () => widget.onNavigate?.call('profile'),
                child: Row(
                  children: [
                    Container(
                      width: 31,
                      height: 31,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.5),
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
              child: Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Save Button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              left: 29,
              right: 29,
              bottom: keyboardOpen ? 24 + safeAreaBottom : 90,
              child: _buildSaveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Center(
      child: Stack(
        children: [
          // Profile Picture
          Container(
            width: 183,
            height: 183,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
            ),
<<<<<<< HEAD
            child: ClipOval(
              child: _isUploadingImage
                  ? const Center(child: CircularProgressIndicator())
                  : _profileImageFile != null
                      ? Image.file(_profileImageFile!, fit: BoxFit.cover)
                      : (_profileImageUrl != null && _profileImageUrl!.isNotEmpty)
                          ? Image.network(_profileImageUrl!, fit: BoxFit.cover)
                          : const Icon(Icons.person, size: 80, color: Colors.black),
            ),
=======
            child: const Icon(Icons.person, size: 80, color: Colors.black),
>>>>>>> 0fdd0ad9a038a4b24a22527ade98b9e8976c8724
          ),
          // Edit Button
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _showImagePicker,
              child: Container(
                width: 51,
                height: 51,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF5A5A5A), width: 1),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.edit, color: Color(0xFF909090), size: 24),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF5A5A5A), width: 1),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email address',
                    hintStyle: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.edit, color: Color(0xFF909090), size: 24),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
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
          onTap: _saveProfile,
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () async {
                      Navigator.pop(context);
                      await _pickAndUploadImage(ImageSource.camera);
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () async {
                      Navigator.pop(context);
                      await _pickAndUploadImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile == null) return;

    setState(() {
      _isUploadingImage = true;
    });

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      final file = File(pickedFile.path);
      final fileExt = path.extension(file.path);
      final fileName = 'profile_${user.id}${DateTime.now().millisecondsSinceEpoch}$fileExt';
      final storagePath = 'profile_pictures/$fileName';

      // Upload to Supabase Storage (bucket: 'avatars' or your bucket name)
      final storageResponse = await Supabase.instance.client.storage
          .from('avatars')
          .upload(storagePath, file, fileOptions: const FileOptions(upsert: true));

      if (storageResponse.isEmpty) {
        throw Exception('Failed to upload image');
      }

      // Get public URL
      final publicUrl = Supabase.instance.client.storage
          .from('avatars')
          .getPublicUrl(storagePath);

      // Update user metadata
      final updateRes = await Supabase.instance.client.auth.updateUser(
        UserAttributes(data: {'profile_image_url': publicUrl}),
      );
      if (updateRes.user == null) throw Exception('Failed to update user metadata');

      setState(() {
        _profileImageFile = file;
        _profileImageUrl = publicUrl;
        _isUploadingImage = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated!'), backgroundColor: Colors.green),
      );
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, size: 30, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _saveProfile() async {
    final supabase = Supabase.instance.client;
    final newEmail = _emailController.text.trim();
    final newUsername = _usernameController.text.trim();

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user is currently logged in.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Update email if changed
      if (newEmail != user.email) {
        final emailRes = await supabase.auth.updateUser(
          UserAttributes(email: newEmail),
        );
        if (emailRes.user == null) {
          throw Exception('Failed to update email.');
        }
      }

      // Update username in user_metadata if changed
      if (newUsername != (user.userMetadata?['username'] ?? '')) {
        final metaRes = await supabase.auth.updateUser(
          UserAttributes(data: {'username': newUsername}),
        );
        if (metaRes.user == null) {
          throw Exception('Failed to update username.');
        }
      }

      Navigator.of(context).pop(); // Remove loading indicator

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Optionally refresh session/user info here

      // Navigate back to profile screen
      widget.onNavigate?.call('profile');
    } catch (e) {
      Navigator.of(context).pop(); // Remove loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
