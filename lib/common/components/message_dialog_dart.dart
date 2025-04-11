import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MessageType {
  success,
  error,
  info
}

class MessageDialog extends StatefulWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onConfirm;
  final bool showCloseButton;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? buttonColor;
  final MessageType type;

  const MessageDialog({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onConfirm,
    this.showCloseButton = true,
    this.backgroundColor,
    this.titleColor,
    this.messageColor,
    this.buttonColor,
    this.type = MessageType.info,
  }) : super(key: key);

  static Future<Object?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    bool showCloseButton = true,
    Color? backgroundColor,
    Color? titleColor,
    Color? messageColor,
    Color? buttonColor,
    MessageType type = MessageType.info,
    bool useHaptic = true,
  }) async {
    if (useHaptic) {
      HapticFeedback.mediumImpact();
    }

    return await showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Fermer dialogue',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return MessageDialog(
          title: title,
          message: message,
          buttonText: buttonText,
          onConfirm: onConfirm,
          showCloseButton: showCloseButton,
          backgroundColor: backgroundColor,
          titleColor: titleColor,
          messageColor: messageColor,
          buttonColor: buttonColor,
          type: type,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconAnimation;

  IconData get _getIcon {
    switch (widget.type) {
      case MessageType.success:
        return Icons.check_circle_outline;
      case MessageType.error:
        return Icons.error_outline;
      case MessageType.info:
        return Icons.info_outline;
    }
  }

  Color _getTypeColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (widget.type) {
      case MessageType.success:
        return Colors.green;
      case MessageType.error:
        return theme.colorScheme.error;
      case MessageType.info:
        return theme.colorScheme.primary;
    }
  }

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _iconAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.elasticOut,
      ),
    );

    _iconController.forward();
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typeColor = _getTypeColor(context);

    return Dialog(
      backgroundColor: widget.backgroundColor ?? theme.colorScheme.surface,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showCloseButton)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ScaleTransition(
              scale: _iconAnimation,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon,
                  color: typeColor,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: widget.titleColor ?? typeColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: widget.messageColor ?? theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onConfirm != null) {
                    widget.onConfirm!();
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.buttonColor ?? typeColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.buttonText ?? 'OK',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}