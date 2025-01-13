import 'package:flutter/material.dart';

class TagCustom extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool? withBorder;
  final double? radius;
  final Widget? prefixIcon;
  const TagCustom(
      {super.key,
      required this.data,
      this.color = Colors.black,
      this.borderColor,
      this.textColor,
      this.prefixIcon,
      this.radius,
      this.withBorder});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color!.withValues(alpha: 0.2),
        border: withBorder == true
            ? Border.all(color: borderColor ?? Colors.black, width: 0.5)
            : null,
        borderRadius: BorderRadius.circular(radius ?? 50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null)
            Padding(
                padding: const EdgeInsets.only(right: 5), child: prefixIcon),
          Text(data,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: color, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
