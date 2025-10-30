import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({Key? key}) : super(key: key);

  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _enableAllNotifications = false;
  bool _bootcampNotifications = true;
  bool _coachingNotifications = true;
  bool _communityNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notification Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enable All Notifications
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enable All Notifications',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Control all notification preferences',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Toggle Switch
                  Switch(
                    value: _enableAllNotifications,
                    onChanged: (bool value) {
                      setState(() {
                        _enableAllNotifications = value;
                        if (_enableAllNotifications) {
                          _bootcampNotifications = true;
                          _coachingNotifications = true;
                          _communityNotifications = true;
                        }
                      });
                    },
                    activeColor: Color(0xFF2C3E50),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // General Notifications Section
            Text(
              'General Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            // Bootcamp Notifications
            _buildNotificationOption(
              title: 'Bootcamp Notifications',
              description: 'Get notified whenever a new Bootcamp video is added.',
              value: _bootcampNotifications,
              onChanged: (bool value) {
                setState(() {
                  _bootcampNotifications = value;
                  _updateAllNotificationsToggle();
                });
              },
            ),

            const SizedBox(height: 16),

            // Coaching Application Notifications
            _buildNotificationOption(
              title: 'Coaching Application Notifications',
              description: 'Receive confirmation alerts after you apply for coaching sessions.',
              value: _coachingNotifications,
              onChanged: (bool value) {
                setState(() {
                  _coachingNotifications = value;
                  _updateAllNotificationsToggle();
                });
              },
            ),

            const SizedBox(height: 16),

            // Community Notifications
            _buildNotificationOption(
              title: 'Community Notifications',
              description: 'Be alerted when someone comments or replies to your post.',
              value: _communityNotifications,
              onChanged: (bool value) {
                setState(() {
                  _communityNotifications = value;
                  _updateAllNotificationsToggle();
                });
              },
            ),

            const SizedBox(height: 32),

            // Save Indicator
            Center(
              child: Text(
                'Changes will save automatically',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Toggle Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF2C3E50),
          ),
        ],
      ),
    );
  }

  void _updateAllNotificationsToggle() {
    if (_bootcampNotifications && _coachingNotifications && _communityNotifications) {
      setState(() {
        _enableAllNotifications = true;
      });
    } else {
      setState(() {
        _enableAllNotifications = false;
      });
    }
  }
}