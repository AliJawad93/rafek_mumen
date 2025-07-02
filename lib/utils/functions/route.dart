import 'package:flutter/material.dart';
import 'package:rafek_mumen/main.dart';

enum TransitionType { slideTop, slideLeft, slideRight, fade, scale, rotate }

go(Widget page, {int? milliseconds, TransitionType? transitionType}) {
  navigatorKey.currentState!.push(
    PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return page;
      },
      transitionDuration: Duration(milliseconds: milliseconds ?? 400),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        return getTransition(animation, child, transitionType);
      },
    ),
  );
}

goReplacemnt(Widget page, {int? milliseconds, TransitionType? transitionType}) {
  navigatorKey.currentState!.pushReplacement(
    PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return page;
      },
      transitionDuration: Duration(milliseconds: milliseconds ?? 500),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        return getTransition(animation, child, transitionType);
      },
    ),
  );
}

goAndRemoveUntil(
  Widget page, {
  int? milliseconds,
  TransitionType? transitionType,
}) {
  navigatorKey.currentState!.pushAndRemoveUntil(
    PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return page;
      },
      transitionDuration: Duration(milliseconds: milliseconds ?? 500),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        return getTransition(animation, child, transitionType);
      },
    ),
    (route) => false,
  );
}

Widget getTransition(
  Animation<double> animation,
  Widget child,
  TransitionType? transitionType,
) {
  switch (transitionType) {
    case TransitionType.slideTop:
      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    case TransitionType.fade:
      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
      return FadeTransition(opacity: animation, child: child);

    case TransitionType.slideLeft:
      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

    case TransitionType.slideRight:
      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    default:
      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
  }
}

pop({BuildContext? context}) {
  Navigator.pop(context ?? navigatorKey.currentContext!);
}
