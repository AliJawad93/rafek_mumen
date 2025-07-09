import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafek_mumen/src/home/data/models/pray_day_work_model.dart';
import 'package:rafek_mumen/utils/services/gerneral_service.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

import '../../../../utils/theme/app_colors.dart';

class PrayDayWorkPage extends StatefulWidget {
  const PrayDayWorkPage({super.key, required this.prayWork});
  final PrayWork prayWork;

  @override
  State<PrayDayWorkPage> createState() => _PrayDayWorkPageState();
}

class _PrayDayWorkPageState extends State<PrayDayWorkPage>
    with TickerProviderStateMixin {
  // State Variables
  bool isShowFontSize = false;
  bool isAutoScroll = false;

  double fontSize = 20;
  double lineHeight = 1.8;
  double autoScrollSpeed = 1.0;
  double readingProgress = 0.0;

  final ScrollController _scrollController = ScrollController();

  // Animation Controllers
  late AnimationController _panelAnimationController;
  late AnimationController _fabAnimationController;
  late AnimationController _appBarAnimationController;
  late AnimationController _progressAnimationController;
  late AnimationController _breathingAnimationController;
  late AnimationController _particleAnimationController;

  late Animation<double> _appBarOpacityAnimation;
  late Animation<double> _breathingAnimation;
  late Animation<double> _particleAnimation;

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setupScrollListener();
    _startBreathingAnimation();
    _startParticleAnimation();
  }

  void _initializeAnimations() {
    _panelAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _appBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _breathingAnimationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _particleAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _appBarOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _appBarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _breathingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _breathingAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _particleAnimationController,
        curve: Curves.linear,
      ),
    );
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      final progress = maxScroll > 0 ? currentScroll / maxScroll : 0.0;

      setState(() {
        readingProgress = progress.clamp(0.0, 1.0);
      });

      final isScrolled = _scrollController.offset > 50;
      if (isScrolled != _isScrolled) {
        setState(() {
          _isScrolled = isScrolled;
        });
        if (isScrolled) {
          _appBarAnimationController.forward();
        } else {
          _appBarAnimationController.reverse();
        }
      }
    });
  }

  void _startBreathingAnimation() {
    _breathingAnimationController.repeat(reverse: true);
  }

  void _startParticleAnimation() {
    _particleAnimationController.repeat();
  }

  @override
  void dispose() {
    _panelAnimationController.dispose();
    _fabAnimationController.dispose();
    _appBarAnimationController.dispose();
    _progressAnimationController.dispose();
    _breathingAnimationController.dispose();
    _particleAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTheme = theme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(effectiveTheme),
      body: Stack(
        children: [
          _buildAnimatedBackground(effectiveTheme),
          _buildContent(effectiveTheme),
          _buildReadingProgress(effectiveTheme),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(ThemeData theme) {
    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surface.withOpacity(0.95),
                    theme.colorScheme.primary.withOpacity(0.02),
                  ],
                ),
              ),
            ),
            // Animated particles
            ...List.generate(5, (index) {
              final offset = (_particleAnimation.value + index * 0.2) % 1.0;
              return Positioned(
                left: (index * 80.0) % MediaQuery.of(context).size.width,
                top: offset * MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: _breathingAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.5 + _breathingAnimation.value * 0.3,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: AnimatedBuilder(
        animation: _appBarOpacityAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface.withOpacity(
                    0.95 * _appBarOpacityAnimation.value,
                  ),
                  theme.colorScheme.surface.withOpacity(
                    0.90 * _appBarOpacityAnimation.value,
                  ),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.1 * _appBarOpacityAnimation.value,
                  ),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
      leading: _buildAppBarButton(
        Icons.arrow_back_ios_new,
        () => Navigator.pop(context),
        theme,
      ),
      title: AnimatedOpacity(
        opacity: _isScrolled ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Text(
          widget.prayWork.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: 'hafs',
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      actions: [
        _buildAppBarButton(CupertinoIcons.textformat_size, () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return _buildFontSizePanel(theme, setModalState);
                },
              );
            },
          );
        }, theme),

        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildAppBarButton(
    IconData icon,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: theme.colorScheme.onSurface, size: 20),
    );
  }

  Widget _buildReadingProgress(ThemeData theme) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + (60),
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: readingProgress,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kPrimaryColor, kBrownColor]),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.top + (80)),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(kAllScreenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(theme),
                const SizedBox(height: 24),
                _buildContentCard(theme),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(ThemeData theme) {
    return AnimatedBuilder(
      animation: _breathingAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + _breathingAnimation.value * 0.02,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kPrimaryColor.withOpacity(0.15),
                  kBrownColor.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: kPrimaryColor.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.2),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Animated background pattern
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [kPrimaryColor, kBrownColor],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "الدعاء المبارك",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: kPrimaryColor.withOpacity(0.8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.prayWork.title,
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        fontFamily: 'hafs',
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                ),
                              ],
                            ),
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
      },
    );
  }

  Widget _buildContentCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: SelectableText(
              widget.prayWork.description,
              textAlign: TextAlign.justify,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontFamily: 'hafs',
                fontSize: fontSize,
                height: lineHeight,
                color: theme.colorScheme.onSurface,
                letterSpacing: 0.8,
                wordSpacing: 2.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primaryContainer.withOpacity(0.4),
                  theme.colorScheme.primaryContainer.withOpacity(0.2),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 12,
                  children: [
                    Expanded(
                      child: _buildActionButton(Icons.copy, "نسخ", () {
                        GeneralService.copyText(widget.prayWork.description);
                      }, theme),
                    ),
                    Expanded(
                      child: _buildActionButton(Icons.share, "مشاركة", () {
                        GeneralService.shareText(
                          widget.prayWork.description,
                          subject: widget.prayWork.title,
                        );
                      }, theme),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.heart_fill,
                      color: kPrimaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "تقبل الله دعاءكم",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedBuilder(
        animation: _breathingAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + _breathingAnimation.value * 0.03,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: kPrimaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: kPrimaryColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFontSizePanel(ThemeData theme, setModalState) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPanelHeader(theme),
          // Font size display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${fontSize.round()}",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Enhanced slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withOpacity(0.3),
              valueIndicatorColor: Colors.white,
              valueIndicatorTextStyle: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              trackHeight: 6,
            ),
            child: Slider(
              value: fontSize,
              max: 40,
              min: 16,
              divisions: 24,
              label: "${fontSize.round()}",
              onChanged: (value) {
                setModalState(() {
                  fontSize = value;
                });
                setState(() {});
              },
            ),
          ),

          // Quick size buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton.tonalIcon(
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                    theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  iconColor: WidgetStateProperty.all(
                    theme.colorScheme.onPrimaryContainer,
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    theme.colorScheme.primaryContainer,
                  ),
                ),
                onPressed: () {
                  setModalState(() {
                    fontSize = 16;
                  });
                  setState(() {});
                },
                label: Text("صغير"),
                icon: Icon(CupertinoIcons.minus_circle_fill),
              ),
              FilledButton.tonalIcon(
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                    theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  iconColor: WidgetStateProperty.all(
                    theme.colorScheme.onPrimaryContainer,
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    theme.colorScheme.primaryContainer,
                  ),
                ),
                onPressed: () {
                  setModalState(() {
                    fontSize = 20;
                  });
                  setState(() {});
                },
                label: Text("متوسط"),
                icon: Icon(CupertinoIcons.circle_fill),
              ),
              FilledButton.tonalIcon(
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                    theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  iconColor: WidgetStateProperty.all(
                    theme.colorScheme.onPrimaryContainer,
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    theme.colorScheme.primaryContainer,
                  ),
                ),
                onPressed: () {
                  setModalState(() {
                    fontSize = 30;
                  });
                  setState(() {});
                },
                label: Text("كبير"),
                icon: Icon(CupertinoIcons.plus_circle_fill),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPanelHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      CupertinoIcons.settings,
                      size: 28,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "إعدادات القراءة",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "تخصيص تجربة القراءة",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
