import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_widgets.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Text(
              'Contacts',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ).animate().fadeIn(duration: 400.ms),

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              borderRadius: 14,
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: AppTheme.textMuted,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search contacts...',
                        hintStyle: TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

          const SizedBox(height: 16),

          // Online section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'ONLINE — ${_onlineContacts.length}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.textMuted,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Contact list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ..._onlineContacts.asMap().entries.map(
                  (e) => _buildContactTile(e.value, e.key, true),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'OFFLINE — ${_offlineContacts.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMuted,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                ..._offlineContacts.asMap().entries.map(
                  (e) => _buildContactTile(
                    e.value,
                    e.key + _onlineContacts.length,
                    false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(
    Map<String, String> contact,
    int index,
    bool isOnline,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          UserAvatar(
            displayName: contact['name']!,
            status: isOnline ? 'online' : 'offline',
            size: 44,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contact['role']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _actionButton(Icons.chat_bubble_outline_rounded),
              const SizedBox(width: 4),
              _actionButton(Icons.videocam_outlined),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: 400.ms,
      delay: Duration(milliseconds: 30 * index),
    );
  }

  Widget _actionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.glassWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppTheme.textSecondary, size: 18),
    );
  }
}

final _onlineContacts = [
  {'name': 'Alice Martin', 'role': 'Senior Engineer'},
  {'name': 'Bob Johnson', 'role': 'DevOps Lead'},
  {'name': 'Claire Wu', 'role': 'Product Manager'},
  {'name': 'David Kim', 'role': 'Frontend Developer'},
  {'name': 'Eva Chen', 'role': 'UX Designer'},
];

final _offlineContacts = [
  {'name': 'Frank Lee', 'role': 'Backend Engineer'},
  {'name': 'Grace Park', 'role': 'QA Lead'},
  {'name': 'Henry Zhang', 'role': 'Security Analyst'},
  {'name': 'Iris Nakamura', 'role': 'Project Manager'},
  {'name': 'Jake Wilson', 'role': 'Systems Admin'},
];
