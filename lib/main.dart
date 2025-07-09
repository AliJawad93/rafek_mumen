import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rafek_mumen/colors.dart';
import 'package:rafek_mumen/src/bottom_nav/presentation/bottom_nav_bar.dart';
import 'package:rafek_mumen/src/home/presentation/bloc/home_bloc.dart';
import 'package:rafek_mumen/src/quran/presentation/blocs/quran_bloc.dart';
import 'package:rafek_mumen/src/set_location/set_location.dart';
import 'package:rafek_mumen/utils/services/local_db.dart';
import 'package:rafek_mumen/utils/services/nofications_serivce.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ThemeNotifier {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initFunctions();
  // FlutterNativeSplash.remove();
  runApp(const MyApp());
}

initFunctions() async {
  await Future.wait([
    LocalDatabase.init(),
    NotificationsService.init(),
    Future.delayed(const Duration(seconds: 2)),
  ]);
  NotificationsService.requestNotificationPermissions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
        BlocProvider<QuranBloc>(create: (BuildContext context) => QuranBloc()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeNotifier.mode,
        builder: (context, currentMode, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Islam',
            supportedLocales: const [
              Locale('ar', ''),
              // Locale('en', ''),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (Locale supportedLocaleLanguage in supportedLocales) {
                if (supportedLocaleLanguage.languageCode ==
                        locale!.languageCode &&
                    supportedLocaleLanguage.countryCode == locale.countryCode) {
                  return supportedLocaleLanguage;
                }
              }
              return supportedLocales.first;
            },

            // builder: (context, child) {
            //   return Overlay(
            //     initialEntries: [
            //       OverlayEntry(builder: (context) => child ?? const SizedBox()),
            //       OverlayEntry(
            //         builder: (context) => Positioned(
            //           top: 40,
            //           right: 16,
            //           child: SafeArea(
            //             child: FloatingActionButton.small(
            //               heroTag: 'themeToggle',
            //               tooltip: 'تبديل السمة',
            //               child: const Icon(Icons.brightness_6),
            //               onPressed: () {
            //                 final isDark =
            //                     ThemeNotifier.mode.value == ThemeMode.dark;
            //                 ThemeNotifier.mode.value = isDark
            //                     ? ThemeMode.light
            //                     : ThemeMode.dark;
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   );
            // },
            navigatorKey: navigatorKey,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: currentMode,
            home: false
                ? ColorSchemeViewer()
                : LocalDatabase.getCityCoordinate() == null
                ? const CitySelectorListView()
                : const Dashboard(),
          );
        },
      ),
    );
  }
}
