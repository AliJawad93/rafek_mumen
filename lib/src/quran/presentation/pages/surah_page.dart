import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/quran/data/models/quran_model.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../utils/theme/app_colors.dart';
import '../functions/functions.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key, required this.surah, this.pageOfAyah});
  final Surah surah;
  final int? pageOfAyah;

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  String? combinedText;
  double fontSize = 24;
  Map<int, (String, int)> combinedTextMap = {};
  bool isShowFontSize = false;
  final ItemScrollController itemScrollController = ItemScrollController();
  @override
  void initState() {
    combinedTextMap = groupAyahsByPage(widget.surah.ayahs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var keysList = combinedTextMap.keys.toList();
    if (widget.pageOfAyah != null) {
      var index = keysList.indexOf(widget.pageOfAyah!);

      log("pageOfAyah: ${widget.pageOfAyah} $index");
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => itemScrollController.scrollTo(
          index: index,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xfffcf9f4),
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          widget.surah.name,
          textAlign: TextAlign.center,
          style: getTextTheme(
            context,
            24,
          )?.copyWith(fontFamily: 'hafs2', color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isShowFontSize = !isShowFontSize;
              });
            },
            icon: const Icon(
              CupertinoIcons.textformat_size,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SurhaListView(
              itemScrollController: itemScrollController,
              combinedTextMap: combinedTextMap,
              widget: widget,
              fontSize: fontSize,
            ),
            !isShowFontSize
                ? const SizedBox()
                : Container(
                    width: getWidth(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: kWidgetPadding,
                      vertical: kWidgetPadding / 2,
                    ),
                    color: kPrimaryColor,
                    child: Column(
                      children: [
                        Slider(
                          thumbColor: kBrownColor,
                          activeColor: kBrownColor,
                          inactiveColor: Colors.white,
                          secondaryActiveColor: Colors.white,
                          value: fontSize,
                          max: 40,
                          min: 16,
                          onChanged: (value) {
                            setState(() {
                              fontSize = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "تعديل حجم الخط",
                              style: getTextTheme(
                                context,
                                16,
                              )?.copyWith(color: Colors.white),
                            ),

                            // Icon(Icons.format_size_outlined),
                            const Icon(
                              CupertinoIcons.textformat_size,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class SurhaListView extends StatelessWidget {
  const SurhaListView({
    super.key,
    required this.itemScrollController,
    required this.combinedTextMap,
    required this.widget,
    required this.fontSize,
  });

  final ItemScrollController itemScrollController;
  final Map<int, (String, int)> combinedTextMap;
  final SurahPage widget;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemCount: combinedTextMap.length,
        itemBuilder: (context, index) {
          var e = combinedTextMap.entries.elementAt(index);
          var currentPage = combinedTextMap[e.key - 1] == null && e.key.isEven
              ? (e.key - 1, false)
              : e.key.isEven
              ? (e.key - 1, false)
              : (e.key, true);
          int nextPage = currentPage.$1 + 1;

          return Column(
            children: [
              if (index == 0) ...[
                // Image.asset('assets/images/im1.jpeg'),
                Padding(
                  padding: const EdgeInsets.all(
                    kWidgetPadding,
                  ).copyWith(bottom: 0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/header23.svg',
                        color: kPrimaryColor,
                      ),
                      Text(
                        widget.surah.name,
                        textAlign: TextAlign.center,
                        style: getTextTheme(
                          context,
                          fontSize.toInt(),
                        )?.copyWith(fontFamily: 'hafs2', color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
              SurahHader(e: e, currentPage: currentPage, nextPage: nextPage),
              if (widget.surah.number != 1 &&
                  widget.surah.number != 9 &&
                  index == 0)
                Center(
                  child: Text(
                    "بِسْمِ اللهِ الرحْمَٰنِ الرحِيمِ",
                    textAlign: TextAlign.center,
                    style: getTextTheme(
                      context,
                      fontSize.toInt(),
                    )?.copyWith(fontFamily: 'hafs2', color: Colors.black),
                  ),
                ),
              const SizedBox(height: kWidgetPadding),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  e.value.$1,
                  textAlign: TextAlign.justify,
                  style: getTextTheme(
                    context,
                    fontSize.toInt(),
                  )?.copyWith(fontFamily: 'hafs2', color: Colors.black),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SurahHader extends StatelessWidget {
  const SurahHader({
    super.key,
    required this.e,
    required this.currentPage,
    required this.nextPage,
  });

  final MapEntry<int, (String, int)> e;
  final (int, bool) currentPage;
  final int nextPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: kPrimaryColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "جزاء (${e.value.$2.toArabic()}) ",
            style: getTextTheme(context, 18)?.copyWith(color: Colors.black),
          ),
          const Spacer(),
          BookCard(pageNumber: currentPage.$1, isFullColor: currentPage.$2),
          BookCard(pageNumber: nextPage, isFullColor: !currentPage.$2),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.pageNumber,
    required this.isFullColor,
  });
  final int pageNumber;
  final bool isFullColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isFullColor ? kPrimaryColor : null,
        border: Border.all(color: kPrimaryColor),
      ),
      child: Text(
        pageNumber.toArabic(),
        style: TextStyle(
          fontSize: 16,
          color: isFullColor ? const Color(0xfffcf9f4) : kPrimaryColor,
        ),
      ),
    );
  }
}
