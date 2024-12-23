import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/color_constants.dart';
import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_state.dart';

class UpcomingCard extends StatefulWidget {
  const UpcomingCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.autopayText,
    required this.installmentText,
    required this.logoText,
    required this.logoColor,
  });
  final String title;
  final String date;
  final String amount;
  final String autopayText;
  final String installmentText;
  final String logoText;
  final Color logoColor;
  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: widget.logoColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.logoText,
                  style: TextStyle(
                    color: widget.logoColor == Colors.white
                        ? Colors.black
                        : Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: themeState.isDark
                          ? ColorConstants.lightBackground
                          : ColorConstants.darkBackground,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.autopayText,
                    style: TextStyle(
                      color: themeState.isDark
                          ? ColorConstants.lightBackground
                          : ColorConstants.darkBackground,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.installmentText.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          widget.installmentText,
                          style: TextStyle(
                            color: themeState.isDark
                                ? ColorConstants.lightBackground
                                : ColorConstants.darkBackground,
                            fontSize: 12,
                          ),
                        ),
                        // const SizedBox(width: 4),
                        // Image.asset(
                        //   'assets/visa.png',
                        //   width: 24,
                        //   height: 16,
                        // ),
                        const SizedBox(width: 4),
                        Text(
                          '••••9207',
                          style: TextStyle(
                            color: themeState.isDark
                                ? ColorConstants.lightBackground
                                : ColorConstants.darkBackground,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Text(
              widget.amount,
              style: TextStyle(
                color: themeState.isDark
                    ? ColorConstants.lightBackground
                    : ColorConstants.darkBackground,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
