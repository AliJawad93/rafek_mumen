import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/core/services/prayer_time.dart';
import 'package:rafek_mumen/src/home/presentation/bloc/home_bloc.dart';
import 'package:rafek_mumen/src/home/presentation/controller/pray_timer_controller.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

import 'widgets/date_and_time.dart';
import 'widgets/pray_days_work.dart';
import 'widgets/pray_times.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PrayerTime prayerTime = PrayerTime();
  PrayTimerController prayTimerController = PrayTimerController();
  late HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(const GetPrayDayWork());
    prayTimerController.onInit();
  }

  @override
  void dispose() {
    prayTimerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: getHeight(),
        width: getWidth(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: getHeight(),
              width: getWidth(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kThirdColor.withOpacity(0.5),
                    kThirdColor.withOpacity(0),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: SizedBox(
                width: getWidth(),
                child: Padding(
                  padding: 16.horizontalEdgeInsets,
                  child: Column(
                    children: [
                      DateAndTime(prayTimerController: prayTimerController),
                      PrayTimes(prayTimerController: prayTimerController),
                      PrayDaysWork(homeBloc: homeBloc),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
