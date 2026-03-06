import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_widgets.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String name;
  final String status;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.name,
    required this.status,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(child: _buildMessageList()),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.darkSurface.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(color: AppTheme.glassBorder, width: 0.5),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
                  ),
                  UserAvatar(
                    displayName: widget.name,
                    status: widget.status,
                    size: 38,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: widget.status == 'online'
                                    ? AppTheme.online
                                    : AppTheme.offline,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.status == 'online' ? 'Online' : 'Offline',
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.status == 'online'
                                    ? AppTheme.online
                                    : AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildAppBarAction(Icons.videocam_rounded),
                  _buildAppBarAction(Icons.call_rounded),
                  _buildAppBarAction(Icons.more_vert_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarAction(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: AppTheme.textSecondary, size: 22),
        style: IconButton.styleFrom(
          backgroundColor: AppTheme.glassWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      reverse: true,
      itemCount: _mockMessages.length,
      itemBuilder: (context, index) {
        final msg = _mockMessages[_mockMessages.length - 1 - index];
        final isMe = msg['isMe'] as bool;
        final showAvatar =
            !isMe &&
            (index == _mockMessages.length - 1 ||
                _mockMessages[_mockMessages.length - index]['isMe'] == true);

        return _buildMessageBubble(msg, isMe, showAvatar, index);
      },
    );
  }

  Widget _buildMessageBubble(
    Map<String, dynamic> msg,
    bool isMe,
    bool showAvatar,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar) ...[
            UserAvatar(
              displayName: widget.name,
              status: widget.status,
              size: 30,
              showStatus: false,
            ),
            const SizedBox(width: 8),
          ] else if (!isMe) ...[
            const SizedBox(width: 38),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? AppTheme.myMessageBg : AppTheme.otherMessageBg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
                border: isMe
                    ? null
                    : Border.all(color: AppTheme.glassBorder, width: 0.5),
                boxShadow: [
                  if (isMe)
                    BoxShadow(
                      color: AppTheme.primaryStart.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg['text'] as String,
                    style: TextStyle(
                      color: isMe ? Colors.white : AppTheme.textPrimary,
                      fontSize: 14.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        msg['time'] as String,
                        style: TextStyle(
                          color: isMe
                              ? Colors.white.withValues(alpha: 0.6)
                              : AppTheme.textMuted,
                          fontSize: 11,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.done_all_rounded,
                          size: 14,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: 300.ms,
      delay: Duration(milliseconds: 20 * index),
    );
  }

  Widget _buildInputBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.darkSurface.withValues(alpha: 0.9),
            border: Border(
              top: BorderSide(color: AppTheme.glassBorder, width: 0.5),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Attachment button
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.glassWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_rounded,
                        color: AppTheme.textSecondary,
                        size: 22,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Message input
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.glassWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppTheme.glassBorder,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 14,
                              ),
                              maxLines: 4,
                              minLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions_outlined,
                              color: AppTheme.textMuted,
                              size: 22,
                            ),
                            padding: const EdgeInsets.all(8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send button
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryStart.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          _messageController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Mock messages for demo
final _mockMessages = [
  {
    'text': 'Hey! How\'s the LAN deployment going?',
    'time': '2:30 PM',
    'isMe': false,
  },
  {
    'text':
        'Going great! The mDNS discovery is working perfectly across VLANs.',
    'time': '2:31 PM',
    'isMe': true,
  },
  {
    'text': 'That\'s awesome. Did you manage to test the file transfer?',
    'time': '2:32 PM',
    'isMe': false,
  },
  {
    'text':
        'Yes, the chunked transfer with resume is working beautifully. P2P kicks in on the same subnet and relay handles cross-VLAN transfers. 🚀',
    'time': '2:33 PM',
    'isMe': true,
  },
  {
    'text':
        'Can you check the latest build? I\'ve pushed some improvements to the signaling server.',
    'time': '2:34 PM',
    'isMe': false,
  },
  {
    'text':
        'Sure! I\'ll pull and test it now. The WebRTC integration is the next thing I need to verify.',
    'time': '2:35 PM',
    'isMe': true,
  },
  {
    'text':
        'Great. Let me know if you need the TURN server logs. The credential rotation is set to 24h TTL.',
    'time': '2:36 PM',
    'isMe': false,
  },
  {
    'text':
        'Perfect, that should be enough for testing. The end-to-end encryption handshake is also working fine now.',
    'time': '2:37 PM',
    'isMe': true,
  },
];
