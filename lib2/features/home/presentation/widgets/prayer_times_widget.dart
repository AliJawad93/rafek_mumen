import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrayerTimesWidget extends StatefulWidget {
  const PrayerTimesWidget({super.key});

  @override
  State<PrayerTimesWidget> createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget> {
  final List<Map<String, dynamic>> _prayers = [
    {
      'name': 'Fajr',
      'time': '05:00',
      'icon': Icons.wb_twighlight,
      'semantic': 'Fajr prayer',
    },
    {
      'name': 'Dhuhr',
      'time': '12:30',
      'icon': Icons.wb_sunny,
      'semantic': 'Dhuhr prayer',
    },
    {
      'name': 'Asr',
      'time': '16:00',
      'icon': Icons.wb_cloudy,
      'semantic': 'Asr prayer',
    },
    {
      'name': 'Maghrib',
      'time': '19:45',
      'icon': Icons.nightlight,
      'semantic': 'Maghrib prayer',
    },
    {
      'name': 'Isha',
      'time': '21:00',
      'icon': Icons.nights_stay,
      'semantic': 'Isha prayer',
    },
  ];

  int _nextPrayerIndex = 0;
  Duration _countdown = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateNextPrayer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateNextPrayer(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateNextPrayer() {
    final now = TimeOfDay.now();
    int idx = 0;
    Duration? nextDuration;
    for (int i = 0; i < _prayers.length; i++) {
      final t = _prayers[i]['time']!;
      final parts = t.split(':');
      final prayerTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
      final diff = _timeOfDayToDuration(prayerTime) - _timeOfDayToDuration(now);
      if (diff.inSeconds > 0) {
        idx = i;
        nextDuration = diff;
        break;
      }
    }
    nextDuration ??=
        _timeOfDayToDuration(
          TimeOfDay(
            hour: int.parse(_prayers[0]['time']!.split(':')[0]),
            minute: int.parse(_prayers[0]['time']!.split(':')[1]),
          ),
        ) +
        const Duration(days: 1) -
        _timeOfDayToDuration(now);
    setState(() {
      _nextPrayerIndex = idx;
      _countdown = nextDuration!;
    });
  }

  Duration _timeOfDayToDuration(TimeOfDay t) =>
      Duration(hours: t.hour, minutes: t.minute);

  void _showAllPrayersDialog() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Today\'s Prayer Times'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _prayers
              .map(
                (p) => ListTile(
                  leading: Icon(
                    p['icon'],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(p['name']),
                  trailing: Text(p['time']),
                ),
              )
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: _showAllPrayersDialog,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.12),
                Theme.of(context).colorScheme.primary.withOpacity(0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Theme.of(context).colorScheme.primary,
                      semanticLabel: 'Prayer Times Icon',
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Prayer Times',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._prayers.map(
                  (p) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              p['icon'],
                              size: 20,
                              color:
                                  _prayers[_nextPrayerIndex]['name'] ==
                                      p['name']
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                              semanticLabel: p['semantic'],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              p['name'],
                              style: TextStyle(
                                fontWeight:
                                    _prayers[_nextPrayerIndex]['name'] ==
                                        p['name']
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color:
                                    _prayers[_nextPrayerIndex]['name'] ==
                                        p['name']
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          p['time'],
                          style: TextStyle(
                            fontWeight:
                                _prayers[_nextPrayerIndex]['name'] == p['name']
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color:
                                _prayers[_nextPrayerIndex]['name'] == p['name']
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: Theme.of(context).colorScheme.primary,
                        semanticLabel: 'Countdown to next prayer',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Next: ${_prayers[_nextPrayerIndex]['name']} in ${_countdown.inHours.toString().padLeft(2, '0')}:${(_countdown.inMinutes % 60).toString().padLeft(2, '0')}:${(_countdown.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
