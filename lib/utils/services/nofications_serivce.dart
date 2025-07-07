import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const String _channelID = "21024";
  static const String _channelName = "r1afeeqalmuslim";
  static const String _channelID2 = "21023";
  static const String _channelName2 = "r1afeeqalmu3lim";
  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Baghdad"));
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    // _startBackgroundService();
  }

  static createScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    required DateTime dateTime,
    required bool isTest,
  }) async {
    // log("messagezx << tzDateTime >> : $dateTime $body");
    tz.TZDateTime tzDateTime;
    if (isTest) {
      // If it's a test, schedule notification 5 seconds from now.
      tzDateTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    } else {
      // Otherwise, construct TZDateTime based on provided dateTime.
      tzDateTime = tz.TZDateTime(
        tz.local,
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
        dateTime.millisecond,
      );
    }
    // log("messagezx << tzDateTime >> ${tz.local} : $id $tzDateTime");

    if (tzDateTime.isBefore(DateTime.now())) {
      // log("messagexz isBefore : $id $body $dateTime");
      return;
    }
    // log("messagexz: $id $body $dateTime");

    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzDateTime,
        _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelID,
        _channelName,
        importance: Importance.max,
        priority: Priority.max,
        icon: "@mipmap/ic_launcher",
        playSound: true,
        sound: RawResourceAndroidNotificationSound('athan'),
        // sound: UriAndroidNotificationSound('assets/sounds/athan.mp3'),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static createScheduleNotification2({
    int id = 0,
    String? title,
    String? body,
    required DateTime dateTime,
    required bool isTest,
  }) async {
    // log("messagezx << tzDateTime >> : $dateTime $body");
    tz.TZDateTime tzDateTime;
    if (isTest) {
      // If it's a test, schedule notification 5 seconds from now.
      tzDateTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2));
    } else {
      // Otherwise, construct TZDateTime based on provided dateTime.
      tzDateTime = tz.TZDateTime(
        tz.local,
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
        dateTime.millisecond,
      );
    }
    // log("messagezx << tzDateTime >> ${tz.local} : $id $tzDateTime");

    if (tzDateTime.isBefore(DateTime.now())) {
      // log("messagexz isBefore : $id $body $dateTime");
      return;
    }
    // log("messagexz: $id $body $dateTime");

    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzDateTime,
        _notificationDetails2(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        // uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static _notificationDetails2() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelID2,
        _channelName2,
        importance: Importance.max,
        priority: Priority.high,
        icon: "@mipmap/ic_launcher",
        // playSound: true,
        // sound: const RawResourceAndroidNotificationSound('athan'),
        ongoing: true,
        // sound: UriAndroidNotificationSound('assets/sounds/athan.mp3'),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // static _startBackgroundService() async {
  //   var service = FlutterBackgroundService();

  //   await service.configure(
  //       iosConfiguration: IosConfiguration(
  //           onBackground: iosBackground, onForeground: onStart),
  //       androidConfiguration: AndroidConfiguration(
  //         onStart: onStart,
  //         autoStart: true,
  //         isForegroundMode: true,
  //         // notificationChannelId:
  //         //     "coding is life", //comment this line if show white screen and app crash
  //         initialNotificationTitle: "رفيق المسلم",
  //         initialNotificationContent: "التطبيق يعمل في الخلفيه",
  //         foregroundServiceNotificationId: 999,
  //       ));
  //   service.startService();
  // }

  // @pragma("vm:entry-point")
  // static void onStart(ServiceInstance service) {
  //   DartPluginRegistrant.ensureInitialized();

  //   // service.on("setAsForeground").listen((event) {
  //   //   print("foreground ===============");
  //   // });

  //   // service.on("setAsBackground").listen((event) {
  //   //   print("background ===============");
  //   // });

  //   // service.on("stopService").listen((event) {
  //   //   service.stopSelf();
  //   // });

  //   //display notification as service

  //   // _flutterLocalNotificationsPlugin.show(
  //   //   999,
  //   //   "رفيق المسلم",
  //   //   "التطبيق يعمل في الخلفيه",
  //   //   const NotificationDetails(
  //   //     android: AndroidNotificationDetails(
  //   //       _channelID,
  //   //       _channelName,
  //   //       ongoing: true,
  //   //       icon: "@mipmap/ic_launcher",
  //   //     ),
  //   //     iOS: DarwinNotificationDetails(),
  //   //   ),
  //   // );

  //   // print("Background service ${DateTime.now()}");
  // }

  //   @pragma("vm:entry-point")
  //   static Future<bool> iosBackground(ServiceInstance service) async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     DartPluginRegistrant.ensureInitialized();

  //     return true;
  //   }

  //   @pragma('vm:entry-point')
  //   static void notificationTapBackground(
  //       NotificationResponse notificationResponse) {}
  // }

  // import 'dart:developer';

  // import 'package:awesome_notifications/awesome_notifications.dart';

  // class NotificationsService {
  //   static const String _channelKey = "res_sound_1";
  //   static const String _channelGroupKey = "basic_channel_group";
  //   static final AwesomeNotifications _awesomeNotifications =
  //       AwesomeNotifications();
  //   static init() async {
  //     await _awesomeNotifications.initialize(null, [
  //       NotificationChannel(
  //         channelGroupKey: _channelGroupKey,
  //         channelKey: _channelKey,
  //         channelName: "Basic Notification",
  //         channelDescription: "Basic notifications channel",
  //         importance: NotificationImportance.High,
  //         criticalAlerts: true,
  //         // defaultRingtoneType: DefaultRingtoneType.Alarm,
  //         locked: true,
  //         soundSource: 'resource://raw/res_sound_1',
  //       )
  //     ], channelGroups: [
  //       NotificationChannelGroup(
  //         channelGroupKey: _channelGroupKey,
  //         channelGroupName: "Basic Group",
  //       )
  //     ]);
  //     bool isAllowedToSendNotification =
  //         await _awesomeNotifications.isNotificationAllowed();
  //     log("isAllowedToSendNotification : $isAllowedToSendNotification");
  //     if (!isAllowedToSendNotification) {
  //       _awesomeNotifications.requestPermissionToSendNotifications();
  //     }
  //   }

  //   static setListeners() {
  //     _awesomeNotifications.setListeners(
  //         onActionReceivedMethod: onActionReceivedMethod,
  //         onNotificationCreatedMethod: onNotificationCreatedMethod,
  //         onNotificationDisplayedMethod: onNotificationDisplayedMethod,
  //         onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  //   }

  //   @pragma("vm:entry-point")
  //   static Future<void> onNotificationCreatedMethod(
  //       ReceivedNotification receivedNotification) async {
  //     log("isAllowedToSendNotification : onNotificationCreatedMethod");
  //   }

  //   /// Use this method to detect every time that a new notification is displayed
  //   @pragma("vm:entry-point")
  //   static Future<void> onNotificationDisplayedMethod(
  //       ReceivedNotification receivedNotification) async {
  //     log("isAllowedToSendNotification : onNotificationDisplayedMethod");
  //   }

  //   @pragma("vm:entry-point")
  //   static Future<void> onDismissActionReceivedMethod(
  //       ReceivedAction receivedAction) async {
  //     log("isAllowedToSendNotification : onDismissActionReceivedMethod");
  //   }

  //   /// Use this method to detect when the user taps on a notification or action button
  //   @pragma("vm:entry-point")
  //   static Future<void> onActionReceivedMethod(
  //       ReceivedAction receivedAction) async {
  //     log("isAllowedToSendNotification : onActionReceivedMethod");
  //   }

  //   static Future<void> createScheduleNotification({
  //     required int id,
  //     required String title,
  //     required String body,
  //     required DateTime dateTime,
  //     String? timeZone
  //   }) async {
  //     await _awesomeNotifications.createNotification(
  //         schedule: NotificationCalendar(
  //           //weekday: nowDate.day,
  //           second: dateTime.second,
  //           minute: dateTime.minute,
  //           hour: dateTime.hour,
  //           day: dateTime.day,
  //           month: dateTime.month,
  //           year: dateTime.year,
  //           timeZone:timeZone,
  //           repeats: false,
  //           allowWhileIdle: true,
  //         ),
  //         content: NotificationContent(
  //             id: id,
  //             channelKey: _channelKey,
  //             title: title,
  //             body: body,
  //             // autoDismissible:false,
  //             // locked:true,
  //             displayOnBackground: true,
  //             displayOnForeground: true),
  //         localizations: {
  //           'ar': NotificationLocalization(
  //             title: title,
  //             body: body,
  //           ),
  //         });
  //   }

  //   static Future<void> cancelOldScheduledNotifications() async {
  //     await AwesomeNotifications().cancelAllSchedules();
  //   }
  // }
}
