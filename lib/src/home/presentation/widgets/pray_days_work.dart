import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rafek_mumen/core/genarics/bloc_state.dart';
import 'package:rafek_mumen/src/home/data/models/pray_day_work_model.dart';
import 'package:rafek_mumen/src/home/presentation/widgets/worships_of_day_card.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';

import '../bloc/home_bloc.dart';

class PrayDaysWork extends StatelessWidget {
  const PrayDaysWork({super.key, required this.homeBloc});
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    // Find the day of the week
    String day = findDayOfWeekInArabic(date);

    return BlocBuilder<HomeBloc, BlocState<PrayDayWorkModel>>(
      bloc: homeBloc,
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () =>
              const Expanded(child: Center(child: CircularProgressIndicator())),
          data: (prayDayWork) => Expanded(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    " اعمال اليوم $day ",
                    style: getTextTheme(
                      context,
                      18,
                    )?.copyWith(color: kSecondaryColor),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: prayDayWork.prayWork.length,
                    itemBuilder: (context, index) {
                      return WorshipsOfDay(prayDayWork.prayWork[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          failure: (error) => Center(child: SelectableText(error.msg)),
        );
      },
    );
  }

  String findDayOfWeekInArabic(DateTime date) {
    // Define locale to Arabic ('ar')
    var formatter = DateFormat('EEEE', 'ar');

    // Format the date in Arabic
    return formatter.format(date);
  }
}
