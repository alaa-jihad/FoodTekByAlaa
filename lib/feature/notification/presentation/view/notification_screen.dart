import 'package:flutter/material.dart';

import '../../../../core/constants/color.dart';
import '../../domain/entity/notification_item.dart';

class NotificationBottomSheet extends StatefulWidget {
  final List<NotificationItem> notifications;

  const NotificationBottomSheet({super.key, required this.notifications});

  @override
  _NotificationBottomSheetState createState() => _NotificationBottomSheetState();
}

class _NotificationBottomSheetState extends State<NotificationBottomSheet> {
  String _selectedTab = 'All'; // Track the selected tab

  @override
  Widget build(BuildContext context) {
    // Filter notifications based on the selected tab
    List<NotificationItem> filteredNotifications = widget.notifications;
    if (_selectedTab == 'Unread') {
      filteredNotifications = widget.notifications.where((item) => !item.isRead).toList();
    } else if (_selectedTab == 'Read') {
      filteredNotifications = widget.notifications.where((item) => item.isRead).toList();
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
      decoration: BoxDecoration(
        color: COLORs.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -8),
            blurRadius: 17.1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Grabber
          Container(
            margin: const EdgeInsets.only(top: 5.6),
            width: 40.31,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFF3C3C43).withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.8),
            ),
          ),
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 16, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 16, color: Colors.black),
                  onPressed: () {}, // Add functionality if needed
                ),
              ],
            ),
          ),
          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTab(context, 'All', _selectedTab == 'All'),
                const SizedBox(width: 10),
                _buildTab(context, 'Unread', _selectedTab == 'Unread'),
                const SizedBox(width: 10),
                _buildTab(context, 'Read', _selectedTab == 'Read'),
              ],
            ),
          ),
          const Divider(color: Color(0xFFE4E8EE)),
          // Notification List
          Expanded(
            child: Container(
              color: const Color(0xFFF1F6FC), // Light blue background
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notification = filteredNotifications[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Unread Indicator
                            if (!notification.isRead) ...[
                              Container(
                                margin: const EdgeInsets.only(left: 8, top: 8),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF90CDF4),
                                  border: Border.all(color: const Color(0xFF4299E1)),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ] else ...[
                              const SizedBox(width: 16),
                            ],
                            // Notification Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF1A1F36),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification.message,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF1A1F36),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 1),
                                    child: Text(
                                      notification.timestamp,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFFA5ACB8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index < filteredNotifications.length - 1)
                        const Divider(color: Color(0xFFDADEF6)),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: isSelected ? const Color(0xFF3E6898) : const Color(0xFF697386),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: title == 'All' ? 22 : title == 'Unread' ? 63 : 44,
            height: 3,
            color: isSelected ? const Color(0xFFACB3D9) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}