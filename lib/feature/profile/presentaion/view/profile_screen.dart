import 'package:flutter/material.dart';
import 'package:foodtek_app/feature/profile/presentaion/view/profile_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _pushNotificationsEnabled = true;
  bool _promoNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0A0D13),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // Profile Avatar and Name Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar
                  Container(
                    width: 88,
                    height: 88,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF3F3F5), // Background color for the avatar
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ), // Placeholder for the avatar image
                  ),
                  const SizedBox(height: 8),
                  // Name
                  const Text(
                    'Ahmad Daboor',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF1B1B1B),
                    ),
                  ),
                  // Email
                  const Text(
                    'emmie1709@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF838383),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // My Account Section
              _buildSection(
                title: 'My Account',
                children: [
                  _buildNavigationRow(
                    icon: Icons.person_outline,
                    label: 'Personal information',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileDetailsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildNavigationRow(
                    icon: Icons.language,
                    label: 'Language',
                    trailing: const Text(
                      'Arabic',
                      style: TextStyle(
                        fontFamily: 'beIN New Arabic Font 2017',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF838383),
                      ),
                    ),
                    onTap: () {
                      // Navigate to Language screen
                    },
                  ),
                  _buildNavigationRow(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    onTap: () {
                      // Navigate to Privacy Policy screen
                    },
                  ),
                  _buildNavigationRow(
                    icon: Icons.settings_outlined,
                    label: 'Setting',
                    onTap: () {
                      // Navigate to Settings screen
                    },
                  ),
                ],
              ),

              // Notifications Section
              _buildSection(
                title: 'Notifications',
                children: [
                  _buildSwitchRow(
                    icon: Icons.notifications_outlined,
                    label: 'Push Notifications',
                    value: _pushNotificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _pushNotificationsEnabled = value;
                      });
                    },
                  ),
                  _buildSwitchRow(
                    icon: Icons.notifications_outlined,
                    label: 'Promo Notifications',
                    value: _promoNotificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _promoNotificationsEnabled = value;
                      });
                    },
                  ),
                ],
              ),

              // More Section
              _buildSection(
                title: 'More',
                children: [
                  _buildNavigationRow(
                    icon: Icons.help_outline,
                    label: 'Help center',
                    onTap: () {
                      // Navigate to Help Center screen
                    },
                  ),
                  _buildNavigationRow(
                    icon: Icons.logout,
                    label: 'Log out',
                    textColor: const Color(0xFFDC1010),
                    iconColor: const Color(0xFFDC1010),
                    onTap: () {
                      // Handle logout logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out successfully!')),
                      );
                      // Navigate to login screen or perform logout
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF5F5F5)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 15,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF1B1B1B),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRow({
    required IconData icon,
    required String label,
    Color textColor = const Color(0xFF1B1B1B),
    Color iconColor = const Color(0xFF1D1D1D),
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF1D1D1D),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF1B1B1B),
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF3E6898),
          inactiveThumbColor: const Color(0xFFAFAFAF),
        ),
      ],
    );
  }
}