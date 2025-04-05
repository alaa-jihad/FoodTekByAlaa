import 'package:flutter/material.dart';
import 'package:foodtek_app/core/utils/responsive.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final TextEditingController _usernameController = TextEditingController(text: 'Ahmad Daboor');
  final TextEditingController _emailController = TextEditingController(text: 'Loibecket@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '0785639048');
  final TextEditingController _passwordController = TextEditingController(text: '********');
  final TextEditingController _addressController = TextEditingController(text: '123 Al Madina Street, Abdali...');

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
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
              Container(
                width: 380,
                padding: const EdgeInsets.all(12),
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
                    // Username Field
                    _buildInputField(
                      label: 'Username',
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 9),
                    // Email Field
                    _buildInputField(
                      label: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 9),
                    // Phone Number Field
                    _buildInputField(
                      label: 'Phone number',
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 9),
                    // Password Field
                    _buildInputField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 9),
                    // Address Field
                    _buildInputField(
                      label: 'Address',
                      controller: _addressController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Update Button
              GestureDetector(
                onTap: () {
                  // Handle update logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 57,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E6898),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF6C7278),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: 356,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFEDF1F3)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(228, 229, 231, 0.24),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF1A1C1E),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}