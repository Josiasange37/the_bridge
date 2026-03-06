import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_widgets.dart';

class ChannelsScreen extends StatelessWidget {
  const ChannelsScreen({super.key});

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
                Text(
                  'Channels',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Row(
                  children: [
                    GlassContainer(
                      padding: const EdgeInsets.all(10),
                      borderRadius: 14,
                      child: const Icon(
                        Icons.search_rounded,
                        color: AppTheme.textSecondary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GlassContainer(
                      padding: const EdgeInsets.all(10),
                      borderRadius: 14,
                      onTap: () {},
                      child: const Icon(
                        Icons.add_rounded,
                        color: AppTheme.primaryStart,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 20),

          // Channel categories
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryHeader(
                  context,
                  'STARRED',
                  Icons.star_rounded,
                  AppTheme.away,
                ),
                ..._starredChannels.asMap().entries.map(
                  (e) => _buildChannelTile(context, e.value, e.key),
                ),

                const SizedBox(height: 24),

                _buildCategoryHeader(
                  context,
                  'ALL CHANNELS',
                  Icons.tag_rounded,
                  AppTheme.accentCyan,
                ),
                ..._allChannels.asMap().entries.map(
                  (e) => _buildChannelTile(
                    context,
                    e.value,
                    e.key + _starredChannels.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.textMuted,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildChannelTile(
    BuildContext context,
    Map<String, dynamic> channel,
    int index,
  ) {
    return Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: GlassContainer(
            padding: const EdgeInsets.all(14),
            borderRadius: 14,
            color: channel['unread'] > 0
                ? AppTheme.primaryStart.withValues(alpha: 0.06)
                : AppTheme.glassSubtle,
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: (channel['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    channel['isPrivate']
                        ? Icons.lock_rounded
                        : Icons.tag_rounded,
                    color: channel['color'] as Color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            channel['name'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: channel['unread'] > 0
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          if (channel['unread'] > 0)
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
                                '${channel['unread']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${channel['members']} members',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
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

final _starredChannels = [
  {
    'name': 'engineering',
    'members': 42,
    'unread': 12,
    'isPrivate': false,
    'color': AppTheme.primaryStart,
  },
  {
    'name': 'design-team',
    'members': 15,
    'unread': 3,
    'isPrivate': false,
    'color': AppTheme.accentCyan,
  },
];

final _allChannels = [
  {
    'name': 'general',
    'members': 156,
    'unread': 0,
    'isPrivate': false,
    'color': AppTheme.online,
  },
  {
    'name': 'product-updates',
    'members': 89,
    'unread': 5,
    'isPrivate': false,
    'color': AppTheme.away,
  },
  {
    'name': 'security-ops',
    'members': 12,
    'unread': 0,
    'isPrivate': true,
    'color': AppTheme.busy,
  },
  {
    'name': 'devops',
    'members': 28,
    'unread': 0,
    'isPrivate': false,
    'color': AppTheme.primaryEnd,
  },
  {
    'name': 'random',
    'members': 134,
    'unread': 0,
    'isPrivate': false,
    'color': AppTheme.accentTeal,
  },
  {
    'name': 'hiring',
    'members': 8,
    'unread': 0,
    'isPrivate': true,
    'color': AppTheme.primaryStart,
  },
];
