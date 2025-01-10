import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // Temporary data for demonstration
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Nouvelle commande',
      'message': 'Une nouvelle commande a été passée pour Alcool de sodium',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
      'isRead': false,
      'type': 'order',
    },
    {
      'title': 'Livraison confirmée',
      'message': 'La commande #12345 a été livrée avec succès',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
      'type': 'delivery',
    },
    {
      'title': 'Mise à jour du stock',
      'message': 'Le stock de Alcool de sodium est faible',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
      'type': 'stock',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              // Mark all as read
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Aucune notification",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _NotificationItem(
                  title: notification['title'],
                  message: notification['message'],
                  time: notification['time'],
                  isRead: notification['isRead'],
                  type: notification['type'],
                  onTap: () {
                    // Handle notification tap
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: notifications.length,
            ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;
  final String type;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
    required this.onTap,
  });

  IconData _getIconForType(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_cart;
      case 'delivery':
        return Icons.local_shipping;
      case 'stock':
        return Icons.inventory;
      default:
        return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'order':
        return ColorConstants.primaryColor;
      case 'delivery':
        return ColorConstants.blueColor;
      case 'stock':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRead
              ? Colors.transparent
              : _getColorForType(type).withValues(alpha: 0.05),
          border: Border.all(
            color: _getColorForType(type).withValues(alpha: 0.1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColorForType(type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconForType(type),
                color: _getColorForType(type),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              fontWeight:
                                  isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getColorForType(type),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeago.format(time, locale: 'fr'),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
