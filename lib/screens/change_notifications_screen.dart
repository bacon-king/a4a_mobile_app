import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';

class ChangeNotificationsScreen extends StatefulWidget {
  final Function(String)? onNavigate;

  const ChangeNotificationsScreen({super.key, this.onNavigate});

  @override
  State<ChangeNotificationsScreen> createState() =>
      _ChangeNotificationsScreenState();
}

class _ChangeNotificationsScreenState extends State<ChangeNotificationsScreen> {
  bool _medicationEnabled = false;
  bool _appointmentsEnabled = false;
  bool _forumEnabled = false;

  bool _editingMedication = false;
  bool _editingAppointments = false;
  bool _editingForum = false;

  final TextEditingController _medicationController =
      TextEditingController(text: 'Receive notifications for medication.');
  final TextEditingController _appointmentsController = TextEditingController(
      text: 'Receive notifications for clinical appointments.');
  final TextEditingController _forumController = TextEditingController(
      text: 'Receive notifications for forum interactions.');

  @override
  void dispose() {
    _medicationController.dispose();
    _appointmentsController.dispose();
    _forumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    const navBarHeight = 76.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 155,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: screenHeight - 155 - navBarHeight - safeAreaBottom,
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
                    children: [
                      const SizedBox(height: 10),
                      _buildMedicationSection(),
                      const SizedBox(height: 26),
                      _buildAppointmentsSection(),
                      const SizedBox(height: 26),
                      _buildForumSection(),
                      const SizedBox(height: 85),
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
                onTap: () => widget.onNavigate?.call('account'),
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
                'Change Notifications',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            // Save Button (fixed above bottom navigation)
            Positioned(
              left: 29,
              right: 29,
              bottom: 90,
              child: _buildSaveButton(),
            ),

            // Bottom Navigation
            Positioned(
              left: 0,
              bottom: 0,
              child: CustomBottomNavigationBar(
                currentIndex: 2,
                onNavigate: widget.onNavigate,
              ),
            ),
          ],
        ),
      ),
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
          onTap: _handleSave,
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

  void _handleSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Notification preferences saved',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
    widget.onNavigate?.call('account');
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool enabled,
    required ValueChanged<bool> onToggle,
    required bool isEditing,
    required VoidCallback onTapEdit,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Switch(
              value: enabled,
              onChanged: onToggle,
              activeColor: Colors.black,
              inactiveThumbColor: Colors.grey[300],
              inactiveTrackColor: Colors.grey[400],
            ),
          ],
        ),
        if (enabled) const SizedBox(height: 18),
        if (enabled)
          const Text(
            'Text Notification',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (enabled) const SizedBox(height: 1),
        if (enabled)
          isEditing
              ? _buildEditableTextField(
                  controller: controller,
                  onSave:
                      onTapEdit, // placeholder, will be overridden by specific calls
                )
              : _buildReadOnlyText(
                  text: controller.text,
                  onEdit: onTapEdit,
                ),
      ],
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required VoidCallback onSave,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF5A5A5A), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: const InputDecoration(
                hintText: 'Edit notification text',
                hintStyle: TextStyle(color: Color(0xFF5A5A5A), fontSize: 16),
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
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {});
              onSave();
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyText(
      {required String text, required VoidCallback onEdit}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onEdit,
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationSection() {
    return _buildSection(
      icon: Icons.medication_outlined,
      title: 'Enable medication intake alerts',
      subtitle: 'Receive notifications for medication.',
      enabled: _medicationEnabled,
      onToggle: (v) => setState(() => _medicationEnabled = v),
      isEditing: _editingMedication,
      onTapEdit: () => setState(() => _editingMedication = !_editingMedication),
      controller: _medicationController,
    );
  }

  Widget _buildAppointmentsSection() {
    return _buildSection(
      icon: Icons.event_available_outlined,
      title: 'Enable appointment alerts',
      subtitle: 'Receive notifications for clinical appointments.',
      enabled: _appointmentsEnabled,
      onToggle: (v) => setState(() => _appointmentsEnabled = v),
      isEditing: _editingAppointments,
      onTapEdit: () =>
          setState(() => _editingAppointments = !_editingAppointments),
      controller: _appointmentsController,
    );
  }

  Widget _buildForumSection() {
    return _buildSection(
      icon: Icons.forum_outlined,
      title: 'Enable forum notifications',
      subtitle: 'Receive notifications for forum interactions.',
      enabled: _forumEnabled,
      onToggle: (v) => setState(() => _forumEnabled = v),
      isEditing: _editingForum,
      onTapEdit: () => setState(() => _editingForum = !_editingForum),
      controller: _forumController,
    );
  }
}
