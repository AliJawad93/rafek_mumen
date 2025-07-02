import 'package:flutter/material.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';

class PrayerTimeCard extends StatelessWidget {
  final String title;
  final String time;
  final IconData iconData;
  final bool isSelect;

  const PrayerTimeCard({
    super.key,
    required this.title,
    required this.time,
    required this.iconData,
    required this.isSelect,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isSelect ? 12.horizontalEdgeInsets : null,
      decoration: BoxDecoration(
        color: isSelect ? kPrimaryColor.withOpacity(0.8) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: getTextTheme(context, 16)?.copyWith(color: kSecondaryColor),
          ),
          Icon(iconData, color: kSecondaryColor),
          Text(
            time,
            style: getTextTheme(context, 16)?.copyWith(color: kSecondaryColor),
          ),
        ],
      ),
    );
  }
}
