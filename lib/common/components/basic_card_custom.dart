import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/material.dart';


class BasicCardCustom extends StatelessWidget {
  final String title;
  final String subtitle;
  const BasicCardCustom({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstants.grayScale100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorConstants.primaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          // const SizedBox(height: 7),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}