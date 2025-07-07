import 'package:flutter/material.dart';
import 'package:rafek_mumen/src/bottom_nav/presentation/bottom_nav_bar.dart';
import 'package:rafek_mumen/utils/functions/route.dart';
import 'package:rafek_mumen/utils/services/local_db.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

import '../../main.dart';

Map<String, List<double>> iraqCitiesCoordinates = {
  'بغداد': [33.3152, 44.3661],
  'البصرة': [30.5101, 47.7839],
  'الموصل': [36.3541, 43.1436],
  'أربيل': [36.2021, 44.0054],
  'السليمانية': [35.5613, 45.4375],
  'كركوك': [35.4681, 44.3922],
  'النجف': [32.0026, 44.3434],
  'كربلاء': [32.616, 44.0244],
  'الرمادي': [33.4152, 43.2975],
  'الحلة': [32.4794, 44.4328],
  'الناصرية': [31.0364, 46.2627],
  'الفلوجة': [33.3559, 43.7844],
  'العمارة': [31.834, 47.1448],
  'دهوك': [36.8663, 42.9885],
  'السماوة': [31.8457, 44.6291],
  'الكوت': [32.5184, 45.833],
  'الرطبة': [33.6119, 41.6967],
  'سنجار': [36.3217, 41.8739],
  'تكريت': [34.6085, 43.6851],
  'زاخو': [36.7333, 42.9833],
  'بلد': [33.3486, 44.383],
  'القائم': [34.4359, 41.0089],
  'بعقوبة': [33.7476, 44.6054],
  'الكوفة': [32.03, 44.55],
  'الشطرة': [32.5325, 45.8205],
  'السويرة': [32.7297, 44.083],
  'الزبير': [30.4741, 47.8007],
  'بيجي': [34.9209, 43.4886],
  'الديوانية': [31.9927, 44.9251],
  'العزيزية': [31.6363, 44.6183],
  'دهوك': [36.8663, 42.9885],
  'حلبجة': [35.1775, 45.9869],
  'هيت': [33.6253, 42.8139],
  'خانقين': [34.9827, 44.9538],
  'كفري': [34.6947, 44.9603],
};

class CitySelectorListView extends StatelessWidget {
  const CitySelectorListView({super.key});

  // final ThemeData theme;

  // final Function(String? citiesEnum) onSelect;
  // final String? selectEnum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kAllScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text("اختر المحافظة", style: getTextTheme(context, 20)),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: kWidgetPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kRadius),
                  ),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (c, i) {
                      String cityName = iraqCitiesCoordinates.keys.elementAt(i);
                      return ListTile(
                        onTap: () {
                          final coordinates = iraqCitiesCoordinates[cityName];

                          LocalDatabase.setCitiesCoordinate({
                            cityName: coordinates ?? [],
                          });

                          goReplacemnt(const Dashboard());
                        },
                        title: Text(cityName, style: getTextTheme(context, 16)),
                      );
                    },
                    separatorBuilder: (c, i) => const Divider(),
                    itemCount: iraqCitiesCoordinates.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// showSelectorDialog(BuildContext context,
//     {required String title,
//     required Function(String? citiesEnum) onSelect,
//     String? selectEnum}) {
//   final theme = Theme.of(context);

//   showCupertinoModalBottomSheet(
//     context: context,
//     builder: (c) => CitySelectorListView(theme: theme, onSelect: onSelect),
//   );
// }

Future<dynamic> showTMDialog({
  required String title,
  String? msg,
  required Icon icon,
  Function()? onDissmiss,
  Widget? view,
}) {
  final theme = Theme.of(navigatorKey.currentContext!);
  final query = MediaQuery.of(navigatorKey.currentContext!);
  Widget okButton = ElevatedButton(
    child: const Text("back"),
    onPressed: () {
      navigatorKey.currentState!.pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius)),
    // titlePadding:
    //     const EdgeInsets.all(kDefaultPadding * 1.5).copyWith(bottom: 0),
    contentPadding: const EdgeInsets.all(
      kWidgetPadding * 1.5,
    ).copyWith(top: kWidgetPadding),
    insetPadding: const EdgeInsets.symmetric(horizontal: kWidgetPadding),
    actionsPadding: const EdgeInsets.all(kWidgetPadding * 1.5).copyWith(top: 0),
    title: SizedBox(
      width: query.size.width,
      child: Row(
        children: [
          Text(
            title,
            maxLines: 1,
            style: theme.textTheme.titleMedium?.copyWith(color: icon.color),
          ),
          const Spacer(),
          icon,
        ],
      ),
    ),
    content:
        view ??
        Wrap(
          children: [
            Text(msg!, style: theme.textTheme.bodySmall),
            const SizedBox(height: kWidgetPadding, width: double.infinity),
            okButton,
          ],
        ),
  );

  return showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) => onDissmiss != null ? onDissmiss() : null);
}
