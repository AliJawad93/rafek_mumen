import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/core/services/prayer_time.dart';
import 'package:rafek_mumen/src/home/presentation/bloc/home_bloc.dart';
import 'package:rafek_mumen/src/home/presentation/controller/pray_timer_controller.dart';
import 'package:rafek_mumen/src/home/presentation/widgets/hadith_carousel.dart';
import 'package:rafek_mumen/src/home/presentation/widgets/home_app_bar.dart';
import 'package:rafek_mumen/src/home/presentation/widgets/pray_days_work.dart';
import 'package:rafek_mumen/src/home/presentation/widgets/pray_times_card.dart';

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
      appBar: HomeAppBar(),
      body: ListView(
        padding: 16.allEdgeInsets,
        children: [
          PrayCard(prayTimerController: prayTimerController),
          HadithCarousel(),
          DailyPrayersWidget(),
        ],
      ),
    );
  }
}
