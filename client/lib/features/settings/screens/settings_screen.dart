import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Text(
              'Settings',
              style: Theme.of(context).textTheme.displayMedium,
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Profile card
            GlassContainer(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      UserAvatar(
                        displayName: 'John Developer',
                        status: 'online',
                        size: 56,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Developer',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '@johnd',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textMuted,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.online.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                '● Online',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.online,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: AppTheme.textMuted,
                        size: 20,
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 100.ms)
                .slideY(begin: 0.05),

            const SizedBox(height: 24),

            // Server status
            GlassContainer(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppTheme.online,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.online.withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Server Connected',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.online,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Address', '192.168.1.100:3000'),
                  _buildInfoRow('Latency', '2ms'),
                  _buildInfoRow('Online Users', '12'),
                  _buildInfoRow('Active Meetings', '2'),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

            const SizedBox(height: 16),

            // Settings groups
            _buildSettingsGroup('Account', [
              _SettingItem(Icons.person_outline_rounded, 'Profile', null),
              _SettingItem(Icons.key_rounded, 'Security & Privacy', null),
              _SettingItem(
                Icons.devices_rounded,
                'Linked Devices',
                '3 devices',
              ),
            ], 300),

            const SizedBox(height: 16),

            _buildSettingsGroup('Network', [
              _SettingItem(
                Icons.dns_outlined,
                'Server Address',
                '192.168.1.100',
              ),
              _SettingItem(
                Icons.wifi_find_rounded,
                'Auto-Discovery',
                'Enabled',
              ),
              _SettingItem(Icons.vpn_key_outlined, 'Encryption', 'End-to-End'),
            ], 400),

            const SizedBox(height: 16),

            _buildSettingsGroup('Preferences', [
              _SettingItem(Icons.notifications_outlined, 'Notifications', null),
              _SettingItem(Icons.dark_mode_outlined, 'Appearance', 'Dark'),
              _SettingItem(Icons.language_rounded, 'Language', 'English'),
              _SettingItem(Icons.storage_outlined, 'Storage', '2.4 GB used'),
            ], 500),

            const SizedBox(height: 24),

            // Logout button
            GlassContainer(
              padding: const EdgeInsets.all(14),
              onTap: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: AppTheme.busy, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Sign Out',
                    style: TextStyle(
                      color: AppTheme.busy,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 600.ms),

            const SizedBox(height: 20),

            // Version info
            Center(
              child: Text(
                'TheBridge v1.0.0 — Enterprise LAN Platform',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textMuted.withValues(alpha: 0.5),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(
    String title,
    List<_SettingItem> items,
    int delayMs,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.textMuted,
                letterSpacing: 1,
              ),
            ),
          ),
          ...items.map((item) => _buildSettingTile(item)),
        ],
      ),
    ).animate().fadeIn(
      duration: 500.ms,
      delay: Duration(milliseconds: delayMs),
    );
  }

  Widget _buildSettingTile(_SettingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: ListTile(
        dense: true,
        leading: Icon(item.icon, color: AppTheme.textSecondary, size: 22),
        title: Text(
          item.label,
          style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.value != null)
              Text(
                item.value!,
                style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
              ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppTheme.textMuted,
              size: 20,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {},
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String label;
  final String? value;

  _SettingItem(this.icon, this.label, this.value);
}
