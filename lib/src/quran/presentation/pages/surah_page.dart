import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/quran/data/models/quran_model.dart';
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

class _SurahPageState extends State<SurahPage> with TickerProviderStateMixin {
  String? combinedText;
  double fontSize = 24;
  Map<int, (String, int)> combinedTextMap = {};
  bool isShowFontSize = false;
  bool isNightMode = false;
  late AnimationController _fontSizeController;
  late AnimationController _fabController;
  late Animation<double> _fontSizeAnimation;
  late Animation<double> _fabAnimation;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int currentVisibleIndex = 0;
  bool showScrollToTop = false;

  @override
  void initState() {
    combinedTextMap = groupAyahsByPage(widget.surah.ayahs);
    _fontSizeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fontSizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fontSizeController, curve: Curves.elasticOut),
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));

    // Listen to scroll position
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final visibleIndex = positions.first.index;
        if (mounted) {
          setState(() {
            currentVisibleIndex = visibleIndex;
            showScrollToTop = visibleIndex > 2;
          });
          if (showScrollToTop) {
            _fabController.forward();
          } else {
            _fabController.reverse();
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _fontSizeController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _toggleFontSizePanel() {
    HapticFeedback.lightImpact();
    setState(() {
      isShowFontSize = !isShowFontSize;
    });
    if (isShowFontSize) {
      _fontSizeController.forward();
    } else {
      _fontSizeController.reverse();
    }
  }

  void _scrollToTop() {
    HapticFeedback.mediumImpact();
    itemScrollController.scrollTo(
      index: 0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  void _adjustFontSize(double delta) {
    HapticFeedback.selectionClick();
    setState(() {
      fontSize = (fontSize + delta).clamp(16.0, 40.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  CupertinoIcons.chevron_forward,
                  color: theme.iconTheme.color,
                ),
              ),
              title: Column(
                children: [
                  Text(
                    widget.surah.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontFamily: 'hafs',
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    '${combinedTextMap.length} صفحة',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: _toggleFontSizePanel,
                    icon: AnimatedRotation(
                      turns: isShowFontSize ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        CupertinoIcons.textformat_size,
                        color: isShowFontSize
                            ? kPrimaryColor
                            : theme.iconTheme.color,
                      ),
                    ),
                    tooltip: 'تغيير حجم الخط',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SurhaListView(
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          combinedTextMap: combinedTextMap,
          widget: widget,
          fontSize: fontSize,
          isDark: isDark,
        ),
      ),
    );
  }
}

class SurhaListView extends StatelessWidget {
  const SurhaListView({
    super.key,
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.combinedTextMap,
    required this.widget,
    required this.fontSize,
    required this.isDark,
  });

  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final Map<int, (String, int)> combinedTextMap;
  final SurahPage widget;
  final double fontSize;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: combinedTextMap.length,
      padding: const EdgeInsets.only(top: 20, bottom: 100, left: 16, right: 16),
      itemBuilder: (context, index) {
        var e = combinedTextMap.entries.elementAt(index);
        var currentPage = combinedTextMap[e.key - 1] == null && e.key.isEven
            ? (e.key - 1, false)
            : e.key.isEven
            ? (e.key - 1, false)
            : (e.key, true);
        int nextPage = currentPage.$1 + 1;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 20),
          child: _SurahCard(
            index: index,
            entry: e,
            currentPage: currentPage,
            nextPage: nextPage,
            widget: widget,
            fontSize: fontSize,
            isDark: isDark,
          ),
        );
      },
    );
  }
}

class _SurahCard extends StatefulWidget {
  const _SurahCard({
    required this.index,
    required this.entry,
    required this.currentPage,
    required this.nextPage,
    required this.widget,
    required this.fontSize,
    required this.isDark,
  });

  final int index;
  final MapEntry<int, (String, int)> entry;
  final (int, bool) currentPage;
  final int nextPage;
  final SurahPage widget;
  final double fontSize;
  final bool isDark;

  @override
  State<_SurahCard> createState() => _SurahCardState();
}

class _SurahCardState extends State<_SurahCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.index == 0) ...[_buildSurahHeader(theme)],

                  SurahHeader(
                    e: widget.entry,
                    currentPage: widget.currentPage,
                    nextPage: widget.nextPage,
                    isDark: widget.isDark,
                  ),

                  if (widget.widget.surah.number != 1 &&
                      widget.widget.surah.number != 9 &&
                      widget.index == 0)
                    _buildBasmala(theme),

                  _buildAyahText(theme),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSurahHeader(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            kPrimaryColor.withOpacity(0.15),
            kPrimaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryColor.withOpacity(0.2)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/header23.svg',
            color: kPrimaryColor,
            height: 80,
          ),
          Text(
            widget.widget.surah.name,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontFamily: 'hafs2',
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasmala(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryColor.withOpacity(0.08),
            kPrimaryColor.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor.withOpacity(0.2), width: 1),
      ),
      child: Center(
        child: Text(
          "بِسْمِ اللهِ الرحْمَٰنِ الرحِيمِ",
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontFamily: 'hafs2',
            fontSize: widget.fontSize,
            color: kPrimaryColor,
            fontWeight: FontWeight.w700,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildAyahText(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Text(
        widget.entry.value.$1,
        textAlign: TextAlign.justify,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontFamily: 'hafs2',
          fontSize: widget.fontSize,
          height: 2.0,
          letterSpacing: 0.5,
          wordSpacing: 2.0,
          color: theme.textTheme.headlineSmall?.color,
        ),
      ),
    );
  }
}

class SurahHeader extends StatelessWidget {
  const SurahHeader({
    super.key,
    required this.e,
    required this.currentPage,
    required this.nextPage,
    required this.isDark,
  });

  final MapEntry<int, (String, int)> e;
  final (int, bool) currentPage;
  final int nextPage;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            kPrimaryColor.withOpacity(0.12),
            kPrimaryColor.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor.withOpacity(0.25), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BookCard(
                pageNumber: currentPage.$1,
                isFullColor: currentPage.$2,
                isDark: isDark,
              ),
              const SizedBox(width: 12),
              BookCard(
                pageNumber: nextPage,
                isFullColor: !currentPage.$2,
                isDark: isDark,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kPrimaryColor.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.book, size: 16, color: kPrimaryColor),
                const SizedBox(width: 6),
                Text(
                  "جزء ${e.value.$2.toArabic()}",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
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
    required this.isDark,
  });

  final int pageNumber;
  final bool isFullColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        gradient: isFullColor
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)],
              )
            : null,
        color: isFullColor ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColor, width: 2),
        boxShadow: isFullColor
            ? [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        pageNumber.toArabic(),
        style: theme.textTheme.titleMedium?.copyWith(
          color: isFullColor ? Colors.white : kPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
