import 'package:flutter/material.dart';
import 'package:rafek_mumen/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الإعدادات',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          color: theme.colorScheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'عام',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeNotifier.mode,
                    builder: (context, themeMode, child) {
                      return SwitchListTile(
                        secondary: CircleAvatar(
                          backgroundColor: theme.colorScheme.surface,
                          child: Icon(
                            Icons.brightness_6,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        title: Text(
                          'الوضع الليلي',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'الوضع الحالي: ${themeMode == ThemeMode.dark ? "ليلي" : "نهاري"}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          final isDark =
                              ThemeNotifier.mode.value == ThemeMode.dark;
                          ThemeNotifier.mode.value = isDark
                              ? ThemeMode.light
                              : ThemeMode.dark;
                        },
                      );
                    },
                  ),
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: theme.colorScheme.surface,
                      child: Icon(
                        Icons.notifications_active,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      'الإشعارات',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('تفعيل أو تعطيل إشعارات التطبيق.'),
                    value: _notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => _notificationsEnabled = val),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'حول التطبيق',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.surface,
                      child: Image.asset(
                        'assets/app_logo.png',
                        width: 28,
                        height: 28,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.apps, color: theme.colorScheme.primary),
                      ),
                    ),
                    title: const Text('تطبيق إسلامي'),
                    subtitle: const Text('الإصدار 1.0.0 '),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.star_rate),
                        label: const Text('قيّم التطبيق'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('شكرًا لتقييمك!')),
                          );
                        },
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('مشاركة التطبيق'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم نسخ رابط المشاركة!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
