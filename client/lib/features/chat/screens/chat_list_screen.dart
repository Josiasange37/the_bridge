import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_widgets.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Messages',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.online,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.online.withValues(alpha: 0.6),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '12 online',
                          style: TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GlassContainer(
                  padding: const EdgeInsets.all(10),
                  borderRadius: 14,
                  child: const Icon(
                    Icons.search_rounded,
                    color: AppTheme.textSecondary,
                    size: 22,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

          const SizedBox(height: 16),

          // Online users horizontal scroll
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _mockOnlineUsers.length,
              itemBuilder: (context, index) {
                final user = _mockOnlineUsers[index];
                return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          UserAvatar(
                            displayName: user['name']!,
                            status: 'online',
                            size: 52,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            user['name']!.split(' ').first,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(
                      duration: 400.ms,
                      delay: Duration(milliseconds: 100 * index),
                    )
                    .slideX(begin: 0.2);
              },
            ),
          ),

          const SizedBox(height: 8),

          // Chat list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _mockChats.length,
              itemBuilder: (context, index) {
                final chat = _mockChats[index];
                return _buildChatTile(context, chat, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(
    BuildContext context,
    Map<String, dynamic> chat,
    int index,
  ) {
    return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, _, _) => ChatScreen(
                  chatId: chat['id'],
                  name: chat['name'],
                  status: chat['status'],
                ),
                transitionsBuilder: (_, animation, _, child) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                UserAvatar(
                  displayName: chat['name'],
                  status: chat['status'],
                  size: 50,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              chat['name'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            chat['time'],
                            style: TextStyle(
                              fontSize: 12,
                              color: chat['unread'] > 0
                                  ? AppTheme.primaryStart
                                  : AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat['lastMessage'],
                              style: TextStyle(
                                fontSize: 13,
                                color: chat['unread'] > 0
                                    ? AppTheme.textSecondary
                                    : AppTheme.textMuted,
                                fontWeight: chat['unread'] > 0
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          if (chat['unread'] > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppTheme.primaryGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${chat['unread']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: Duration(milliseconds: 50 * index),
        )
        .slideX(begin: 0.05);
  }
}

// Mock data for demo
final _mockOnlineUsers = [
  {'name': 'Alice Martin', 'avatar': null},
  {'name': 'Bob Johnson', 'avatar': null},
  {'name': 'Claire Wu', 'avatar': null},
  {'name': 'David Kim', 'avatar': null},
  {'name': 'Eva Chen', 'avatar': null},
  {'name': 'Frank Lee', 'avatar': null},
];

final _mockChats = [
  {
    'id': '1',
    'name': 'Alice Martin',
    'lastMessage': 'Hey, can you check the latest build?',
    'time': '2:34 PM',
    'unread': 3,
    'status': 'online',
  },
  {
    'id': '2',
    'name': 'Bob Johnson',
    'lastMessage': 'The deployment is ready for review 🚀',
    'time': '1:12 PM',
    'unread': 1,
    'status': 'online',
  },
  {
    'id': '3',
    'name': 'Engineering Team',
    'lastMessage': 'Claire: Updated the API docs',
    'time': '12:45 PM',
    'unread': 0,
    'status': 'online',
  },
  {
    'id': '4',
    'name': 'David Kim',
    'lastMessage': 'Let me know when the meeting starts',
    'time': '11:30 AM',
    'unread': 0,
    'status': 'away',
  },
  {
    'id': '5',
    'name': 'Product Design',
    'lastMessage': 'Eva: New mockups are in the channel',
    'time': '10:15 AM',
    'unread': 5,
    'status': 'online',
  },
  {
    'id': '6',
    'name': 'Frank Lee',
    'lastMessage': 'Thanks for the code review!',
    'time': 'Yesterday',
    'unread': 0,
    'status': 'offline',
  },
  {
    'id': '7',
    'name': 'Security Team',
    'lastMessage': 'Audit report is complete',
    'time': 'Yesterday',
    'unread': 0,
    'status': 'online',
  },
  {
    'id': '8',
    'name': 'Grace Park',
    'lastMessage': 'See you at the sprint planning',
    'time': 'Mon',
    'unread': 0,
    'status': 'busy',
  },
];
