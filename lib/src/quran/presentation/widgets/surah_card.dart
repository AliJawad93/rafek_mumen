import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/quran/presentation/pages/surah_page.dart';

import '../../../../utils/functions/route.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/app_theme.dart';
import '../../data/models/quran_model.dart';

class SurahCard extends StatelessWidget {
  const SurahCard({super.key, required this.surah});
  final Surah surah;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: SvgPicture.asset(
                "assets/images/star.svg",
                color: kPrimaryColor,
              ),
            ),
            Positioned(
              top: 17,
              child: Text(
                surah.number.toArabic(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      trailing: const Icon(
        CupertinoIcons.forward,
        color: Colors.grey,
        size: 18,
      ),
      onTap: () => go(SurahPage(surah: surah)),
      title: Text(
        surah.name,
        style: getTextTheme(
          context,
          16,
        )?.copyWith(height: 1.5, color: Colors.black),
      ),
      subtitle: Text(
        "${surah.revelationType} | ${surah.ayahs.length.toArabic()} اية",
        style: getTextTheme(context, 14),
      ),
    );
  }
}
// Text(
//                                   chars[index],
//                                   style: getTextTheme(context, 50)?.copyWith(
//                                       fontFamily: 'quran', color: Colors.black),
//                                 ),