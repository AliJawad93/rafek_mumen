import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/home/data/models/pray_day_work_model.dart';
import 'package:rafek_mumen/src/home/presentation/pages/pray_work_page.dart';
import 'package:rafek_mumen/utils/functions/route.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';

class WorshipsOfDay extends StatelessWidget {
  const WorshipsOfDay(this.prayWork, {super.key});
  final PrayWork prayWork;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        go(PrayDayWorkPage(prayWork: prayWork));
      },
      child: Container(
        padding: (14, 16).symmetricEdgeInsets,
        margin: 5.verticalEdgeInsets,
        decoration: BoxDecoration(
          color: kThirdColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/pray.png",
              width: 26,
              height: 26,
              color: const Color.fromARGB(255, 154, 216, 164),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                prayWork.title,
                style: getTextTheme(
                  context,
                  16,
                )?.copyWith(color: kSecondaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(LucideIcons.chevronLeft, color: kSecondaryColor),
          ],
        ),
      ),
    );
  }
}
