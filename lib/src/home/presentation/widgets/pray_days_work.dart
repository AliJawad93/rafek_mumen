import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rafek_mumen/core/genarics/bloc_state.dart';
import 'package:rafek_mumen/src/home/data/models/pray_day_work_model.dart';
import 'package:rafek_mumen/src/home/presentation/pages/pray_work_page.dart';
import 'package:rafek_mumen/utils/functions/route.dart';

import '../bloc/home_bloc.dart';

class DailyPrayersWidget extends StatefulWidget {
  const DailyPrayersWidget({super.key});

  @override
  _DailyPrayersWidgetState createState() => _DailyPrayersWidgetState();
}

class _DailyPrayersWidgetState extends State<DailyPrayersWidget> {
  late HomeBloc homeBloc;
  String day = "";
  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(const GetPrayDayWork());
    day = getDayOfWeekInArabic();
  }

  String getDayOfWeekInArabic() {
    var formatter = DateFormat('EEEE', 'ar');
    return formatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, BlocState<PrayDayWorkModel>>(
      bloc: homeBloc,
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => Center(child: CircularProgressIndicator()),
          data: (prayDayWork) => Column(
            children: [
              // Section Header
              Row(
                children: [
                  Text(
                    'أدعية اليوم',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),

                  Container(
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${prayDayWork.prayWork.length}',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 12,
                        fontFamily: 'Amiri',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'عرض الكل',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Prayers List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: prayDayWork.prayWork.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildPrayerCard(
                    prayDayWork.prayWork[index],
                    index,
                    theme,
                  );
                },
              ),
            ],
          ),
          failure: (error) => Center(child: SelectableText(error.msg)),
        );
      },
    );
  }

  Widget _buildPrayerCard(PrayWork prayer, int index, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: () {
          go(PrayDayWorkPage(prayWork: prayer));
        },
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                "assets/images/pray.png",
                width: 26,
                height: 26,
                color: colorScheme.primary,
              ),
            ),
          ),
          title: Text(
            prayer.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    right: BorderSide(color: colorScheme.primary, width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      prayer.description,
                      maxLines: 2,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book, color: colorScheme.primary, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      prayer.source,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
