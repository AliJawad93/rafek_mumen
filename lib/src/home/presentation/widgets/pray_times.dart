import 'package:flutter/material.dart';
import 'package:rafek_mumen/src/home/presentation/controller/pray_timer_controller.dart';
import 'package:rafek_mumen/src/home/presentation/widgets/prayer_time_card.dart';
import 'package:rafek_mumen/utils/services/prayer_time_services.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

import '../paint/paint.dart';

class PrayTimes extends StatelessWidget {
  const PrayTimes({super.key, required this.prayTimerController});

  final PrayTimerController prayTimerController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: prayTimerController.update,
      builder: (BuildContext context, bool update, child) {
        return InkWell(
          onTap: () => showAllTimes(
            context,
            prayTimerController.prayerTimeService.getprayerTimeEndities,
          ),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                const Spacer(),
                PrayerTimeCard(
                  title: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[0]
                      .title,
                  time: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[0]
                      .time,
                  iconData: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[0]
                      .iconData,
                  isSelect:
                      prayTimerController.prayerTimeService.getnextPrayIndex ==
                      0,
                ),
                const Spacer(),
                PrayerTimeCard(
                  title: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[1]
                      .title,
                  time: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[1]
                      .time,
                  iconData: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[1]
                      .iconData,
                  isSelect:
                      prayTimerController.prayerTimeService.getnextPrayIndex ==
                      1,
                ),
                const Spacer(),
                PrayerTimeCard(
                  title: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[2]
                      .title,
                  time: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[2]
                      .time,
                  iconData: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[2]
                      .iconData,
                  isSelect:
                      prayTimerController.prayerTimeService.getnextPrayIndex ==
                      2,
                ),
                const Spacer(),
                PrayerTimeCard(
                  title: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[4]
                      .title,
                  time: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[4]
                      .time,
                  iconData: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[4]
                      .iconData,
                  isSelect:
                      prayTimerController.prayerTimeService.getnextPrayIndex ==
                      3,
                ),
                const Spacer(),
                PrayerTimeCard(
                  title: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[5]
                      .title,
                  time: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[5]
                      .time,
                  iconData: prayTimerController
                      .prayerTimeService
                      .getprayerTimeEndities[5]
                      .iconData,
                  isSelect:
                      prayTimerController.prayerTimeService.getnextPrayIndex ==
                      4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showAllTimes(context, List<PrayerTimeEndity> getprayerTimeEndities) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      builder: (BuildContext bc) {
        return Column(
          children: [
            Container(
              height: 5,
              width: getWidth() * 0.2,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(kWidgetPadding),
                child: ListView.builder(
                  itemCount: getprayerTimeEndities.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(getprayerTimeEndities[index].iconData),
                              const SizedBox(width: 10),
                              Text(
                                getprayerTimeEndities[index].title,
                                style: getTextTheme(
                                  context,
                                  17,
                                )?.copyWith(color: kThirdColor),
                              ),
                              const Spacer(),
                              Text(
                                getprayerTimeEndities[index].time,
                                style: getTextTheme(
                                  context,
                                  17,
                                )?.copyWith(color: kThirdColor),
                              ),
                            ],
                          ),
                          CustomPaint(painter: DrawDottedhorizontalline()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
