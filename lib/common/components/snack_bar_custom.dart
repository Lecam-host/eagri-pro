import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

class SnackBarCustom {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            _getIconByType(type),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: _getColorByType(type),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Fermer',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static Icon _getIconByType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case SnackBarType.error:
        return const Icon(Icons.error, color: Colors.white);
      case SnackBarType.info:
        return const Icon(Icons.info, color: Colors.white);
    }
  }

  static Color _getColorByType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.info:
        return Colors.blue;
    }
  }
}

// Example usage
class ExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        SnackBarCustom.show(
          context: context,
          message: 'Operation completed successfully',
          type: SnackBarType.success,
        );
      },
      child: Text('Show SnackBar'),
    );
  }
}
