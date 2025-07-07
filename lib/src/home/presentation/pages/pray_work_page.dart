import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafek_mumen/src/home/data/models/pray_day_work_model.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

import '../../../../utils/theme/app_colors.dart';

class PrayDayWorkPage extends StatefulWidget {
  const PrayDayWorkPage({super.key, required this.prayWork});
  final PrayWork prayWork;

  @override
  State<PrayDayWorkPage> createState() => _PrayDayWorkPageState();
}

class _PrayDayWorkPageState extends State<PrayDayWorkPage> {
  bool isShowFontSize = false;

  double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.prayWork.title,
          style: theme.textTheme.headlineSmall?.copyWith(fontFamily: 'hafs'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isShowFontSize = !isShowFontSize;
              });
            },
            icon: const Icon(CupertinoIcons.textformat_size),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(
                kAllScreenPadding,
              ).copyWith(bottom: 0),
              child: Text(
                widget.prayWork.description,
                textAlign: TextAlign.justify,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'hafs',
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
          !isShowFontSize
              ? const SizedBox()
              : Container(
                  width: getWidth(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kWidgetPadding,
                    vertical: kWidgetPadding / 2,
                  ),
                  color: kPrimaryColor,
                  child: Column(
                    children: [
                      Slider(
                        thumbColor: kBrownColor,
                        activeColor: kBrownColor,
                        inactiveColor: Colors.white,
                        secondaryActiveColor: Colors.white,
                        value: fontSize,
                        max: 40,
                        min: 16,
                        onChanged: (value) {
                          setState(() {
                            fontSize = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "تعديل حجم الخط",
                            style: getTextTheme(
                              context,
                              16,
                            )?.copyWith(color: Colors.white),
                          ),

                          // Icon(Icons.format_size_outlined),
                          const Icon(
                            CupertinoIcons.textformat_size,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
