import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? child;

  const AppBarCustom({super.key,  this.title, this.child});

  @override
  Size get preferredSize =>
      const Size.fromHeight(60); // Set the preferred height of the app bar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.primaryColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => context.pop(),
      ),
      title: child ?? Text(
        title ?? '',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
