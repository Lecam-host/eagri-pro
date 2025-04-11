import 'package:flutter/material.dart';

enum MessageType { warning, error, info }

class MessageBanner extends StatelessWidget {
  final String message;
  final MessageType type;

  const MessageBanner({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
      case MessageType.warning:
        return Colors.orange.shade100;
      case MessageType.error:
        return Colors.red.shade100;
      case MessageType.info:
        return Colors.blue.shade100;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case MessageType.warning:
        return Icons.warning_amber_rounded;
      case MessageType.error:
        return Icons.error_outline;
      case MessageType.info:
        return Icons.info_outline;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case MessageType.warning:
        return Colors.orange;
      case MessageType.error:
        return Colors.red;
      case MessageType.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            _getIcon(),
            color: _getIconColor(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: _getIconColor(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
