import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/quran/presentation/blocs/quran_bloc.dart';
import 'package:rafek_mumen/src/quran/presentation/pages/surah_page.dart';
import 'package:rafek_mumen/utils/functions/route.dart';

import '../../../../core/genarics/bloc_state.dart';
import '../../data/models/quran_model.dart';
import '../functions/functions.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late QuranBloc quranBloc;
  ValueNotifier<List<Ayah>> filteredAyahs = ValueNotifier<List<Ayah>>([]);
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    quranBloc = context.read<QuranBloc>();
    quranBloc.add(const GetQuranSurahsEvent());
    filteredAyahs.value = [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void filterAyahs(String text, List<Surah> surahs) {
    String searchText = text.trim();
    if (!searchText.isEnglishWithoutNumbersAndSymbols()) {
      return;
    }
    final normalizedSearchText = removeSpecialArabicChar(searchText);
    setState(() {
      filteredAyahs.value = [];
      searchLoop:
      for (var surah in surahs) {
        for (var ayah in surah.ayahs) {
          final normalizedAyahText = removeSpecialArabicChar(ayah.text);
          if (normalizedAyahText.contains(normalizedSearchText)) {
            filteredAyahs.value.add(ayah);
            if (filteredAyahs.value.length == 8) {
              break searchLoop;
            }
          }
        }
      }
    });
  }

  Surah getSurah(Ayah ayah, List<Surah> surahs) {
    for (var surah in surahs) {
      if (surah.ayahs.contains(ayah)) {
        return surah;
      }
    }
    throw Exception('Surah not found for the Ayah');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocBuilder<QuranBloc, BlocState<QuranModel>>(
        bloc: quranBloc,
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Material 3 App Bar
              SliverAppBar(
                floating: false,
                pinned: true,
                backgroundColor: colorScheme.surface,
                elevation: 0,
                title: Column(
                  children: [
                    Text(
                      'القرآن الكريم',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),

                    Text(
                      'كتاب الله المبين',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 24)),

              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: colorScheme.outline.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          context,
                          'السور',
                          state.maybeWhen(
                            data: (data) => data.surahs.length.toString(),
                            orElse: () => '114',
                          ),
                          Icons.menu_book_rounded,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: colorScheme.onPrimaryContainer.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          context,
                          'الآيات',
                          state.maybeWhen(
                            data: (data) => data.surahs
                                .fold(
                                  0,
                                  (sum, surah) => sum + surah.ayahs.length,
                                )
                                .toString(),
                            orElse: () => '6236',
                          ),
                          Icons.format_list_numbered_rounded,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: colorScheme.onPrimaryContainer.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          context,
                          'الأجزاء',
                          '30',
                          Icons.collections_bookmark_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),

              // Content
              state.when(
                initial: () => const SliverToBoxAdapter(child: SizedBox()),
                loading: () =>
                    SliverToBoxAdapter(child: _buildLoadingState(colorScheme)),
                data: (quranModel) => _buildDataState(quranModel, colorScheme),
                failure: (error) => SliverToBoxAdapter(
                  child: _buildErrorState(error, colorScheme),
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: colorScheme.primary,
              backgroundColor: colorScheme.surfaceContainerHigh,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'جاري تحميل السور الكريمة...',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'الرجاء الانتظار',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataState(QuranModel quranModel, ColorScheme colorScheme) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Material3SurahCard(
          surah: quranModel.surahs[index],
          index: index,
        );
      }, childCount: quranModel.surahs.length),
    );
  }

  Widget _buildErrorState(dynamic error, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Card(
        elevation: 0,
        color: colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: colorScheme.error,
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                'حدث خطأ في تحميل البيانات',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'تعذر تحميل سور القرآن الكريم',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onErrorContainer.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  quranBloc.add(const GetQuranSurahsEvent());
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('إعادة المحاولة'),
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
              ),
              const SizedBox(height: 16),
              SelectableText(
                error.msg,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onErrorContainer.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Material3SurahCard extends StatelessWidget {
  const Material3SurahCard({
    super.key,
    required this.surah,
    required this.index,
  });

  final Surah surah;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMakki = surah.revelationType == 'مكية';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainerLowest,
        // surfaceTintColor: colorScheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.5),
            width: 0,
          ),
        ),
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            go(SurahPage(surah: surah));
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Surah Number with Material 3 styling
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    // border: Border.all(color: colorScheme.primary, width: 2),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset(
                            "assets/images/star.svg",
                            color: colorScheme.primary,
                          ),
                        ),

                        Positioned(
                          top: 14,

                          child: Text(
                            surah.number.toArabic(),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Surah Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Revelation type chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isMakki
                                  ? colorScheme.secondaryContainer
                                  : colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isMakki
                                    ? colorScheme.secondary.withOpacity(0.3)
                                    : colorScheme.tertiary.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isMakki
                                      ? Icons.mosque_outlined
                                      : Icons.location_city_outlined,
                                  size: 14,
                                  color: isMakki
                                      ? colorScheme.onSecondaryContainer
                                      : colorScheme.onTertiaryContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  surah.revelationType,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: isMakki
                                            ? colorScheme.onSecondaryContainer
                                            : colorScheme.onTertiaryContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Ayah count
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.format_list_numbered_rounded,
                                  size: 12,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${surah.ayahs.length.toArabic()} آية",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                        fontWeight: FontWeight.w500,
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

                // Navigation arrow with Material 3 styling
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: colorScheme.primary,
                    size: 16,
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
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:rafek_mumen/core/functions/extension.dart';
// import 'package:rafek_mumen/src/quran/presentation/blocs/quran_bloc.dart';
// import 'package:rafek_mumen/src/quran/presentation/pages/search_page.dart';
// import 'package:rafek_mumen/src/quran/presentation/pages/surah_page.dart';
// import 'package:rafek_mumen/utils/functions/route.dart';

// import '../../../../core/genarics/bloc_state.dart';
// import '../../data/models/quran_model.dart';
// import '../functions/functions.dart';

// class QuranPage extends StatefulWidget {
//   const QuranPage({super.key});

//   @override
//   _QuranPageState createState() => _QuranPageState();
// }

// class _QuranPageState extends State<QuranPage> {
//   late QuranBloc quranBloc;
//   ValueNotifier<List<Ayah>> filteredAyahs = ValueNotifier<List<Ayah>>([]);
//   TextEditingController searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     quranBloc = context.read<QuranBloc>();
//     quranBloc.add(const GetQuranSurahsEvent());
//     filteredAyahs.value = [];
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     searchController.dispose();
//     super.dispose();
//   }

//   void filterAyahs(String text, List<Surah> surahs) {
//     String searchText = text.trim();
//     if (!searchText.isEnglishWithoutNumbersAndSymbols()) {
//       return;
//     }
//     final normalizedSearchText = removeSpecialArabicChar(searchText);
//     setState(() {
//       filteredAyahs.value = [];
//       searchLoop:
//       for (var surah in surahs) {
//         for (var ayah in surah.ayahs) {
//           final normalizedAyahText = removeSpecialArabicChar(ayah.text);
//           if (normalizedAyahText.contains(normalizedSearchText)) {
//             filteredAyahs.value.add(ayah);
//             if (filteredAyahs.value.length == 8) {
//               break searchLoop;
//             }
//           }
//         }
//       }
//     });
//   }

//   Surah getSurah(Ayah ayah, List<Surah> surahs) {
//     for (var surah in surahs) {
//       if (surah.ayahs.contains(ayah)) {
//         return surah;
//       }
//     }
//     throw Exception('Surah not found for the Ayah');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF8F9FA),
//       body: BlocBuilder<QuranBloc, BlocState<QuranModel>>(
//         bloc: quranBloc,
//         builder: (context, state) {
//           return CustomScrollView(
//             controller: _scrollController,
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               // Modern App Bar
//               SliverAppBar(
//                 expandedHeight: 160,
//                 floating: false,
//                 pinned: true,
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 systemOverlayStyle: SystemUiOverlayStyle(
//                   statusBarColor: Colors.transparent,
//                   statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: isDark
//                             ? [
//                                 const Color(0xFF1A1A1A),
//                                 const Color(0xFF0A0A0A),
//                               ]
//                             : [
//                                 const Color(0xFFFFFFFF),
//                                 const Color(0xFFF8F9FA),
//                               ],
//                       ),
//                     ),
//                     child: SafeArea(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'القرآن الكريم',
//                                       style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.w800,
//                                         color: isDark ? Colors.white : const Color(0xFF1A1A1A),
//                                         letterSpacing: -0.5,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       'كتاب الله المبين',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: isDark 
//                                             ? Colors.white.withOpacity(0.7)
//                                             : const Color(0xFF6B7280),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: isDark 
//                                         ? const Color(0xFF2A2A2A)
//                                         : const Color(0xFFF3F4F6),
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                       color: isDark 
//                                           ? const Color(0xFF3A3A3A)
//                                           : const Color(0xFFE5E7EB),
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.settings_outlined,
//                                     color: isDark ? Colors.white : const Color(0xFF374151),
//                                     size: 24,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Search Section
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
//                   child: GestureDetector(
//                     onTap: () {
//                       HapticFeedback.selectionClick();
//                       go(
//                         SearchPage(
//                           surahs: state.maybeWhen(
//                             data: (data) => data.surahs,
//                             orElse: () => [],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: isDark 
//                               ? const Color(0xFF2A2A2A)
//                               : const Color(0xFFE5E7EB),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: isDark 
//                                 ? Colors.black.withOpacity(0.3)
//                                 : Colors.black.withOpacity(0.05),
//                             blurRadius: 20,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF059669).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.search_rounded,
//                               color: Color(0xFF059669),
//                               size: 20,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Text(
//                               'ابحث في القرآن الكريم...',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: isDark 
//                                     ? Colors.white.withOpacity(0.6)
//                                     : const Color(0xFF9CA3AF),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios_rounded,
//                             color: isDark 
//                                 ? Colors.white.withOpacity(0.4)
//                                 : const Color(0xFF9CA3AF),
//                             size: 16,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Content
//               state.when(
//                 initial: () => const SliverToBoxAdapter(child: SizedBox()),
//                 loading: () => SliverToBoxAdapter(
//                   child: _buildLoadingState(isDark),
//                 ),
//                 data: (quranModel) => _buildDataState(quranModel, isDark),
//                 failure: (error) => SliverToBoxAdapter(
//                   child: _buildErrorState(error, isDark),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildLoadingState(bool isDark) {
//     return Container(
//       padding: const EdgeInsets.all(40),
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isDark 
//                     ? const Color(0xFF2A2A2A)
//                     : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: CircularProgressIndicator(
//               strokeWidth: 3,
//               color: const Color(0xFF059669),
//               backgroundColor: const Color(0xFF059669).withOpacity(0.1),
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'جاري تحميل السور الكريمة...',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: isDark ? Colors.white : const Color(0xFF1A1A1A),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'الرجاء الانتظار',
//             style: TextStyle(
//               fontSize: 14,
//               color: isDark 
//                   ? Colors.white.withOpacity(0.6)
//                   : const Color(0xFF6B7280),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDataState(QuranModel quranModel, bool isDark) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           return ModernSurahCard(
//             surah: quranModel.surahs[index],
//             index: index,
//             isDark: isDark,
//           );
//         },
//         childCount: quranModel.surahs.length,
//       ),
//     );
//   }

//   Widget _buildErrorState(dynamic error, bool isDark) {
//     return Container(
//       margin: const EdgeInsets.all(24),
//       padding: const EdgeInsets.all(32),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: isDark 
//               ? const Color(0xFF2A2A2A)
//               : const Color(0xFFE5E7EB),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEF4444).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Icon(
//               Icons.error_outline_rounded,
//               color: Color(0xFFEF4444),
//               size: 48,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'حدث خطأ في تحميل البيانات',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: isDark ? Colors.white : const Color(0xFF1A1A1A),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'تعذر تحميل سور القرآن الكريم',
//             style: TextStyle(
//               fontSize: 16,
//               color: isDark 
//                   ? Colors.white.withOpacity(0.6)
//                   : const Color(0xFF6B7280),
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: () {
//               HapticFeedback.mediumImpact();
//               quranBloc.add(const GetQuranSurahsEvent());
//             },
//             icon: const Icon(Icons.refresh_rounded),
//             label: const Text('إعادة المحاولة'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF059669),
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ModernSurahCard extends StatelessWidget {
//   const ModernSurahCard({
//     super.key,
//     required this.surah,
//     required this.index,
//     required this.isDark,
//   });

//   final Surah surah;
//   final int index;
//   final bool isDark;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             HapticFeedback.selectionClick();
//             go(SurahPage(surah: surah));
//           },
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isDark 
//                     ? const Color(0xFF2A2A2A)
//                     : const Color(0xFFE5E7EB),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: isDark 
//                       ? Colors.black.withOpacity(0.2)
//                       : Colors.black.withOpacity(0.03),
//                   blurRadius: 15,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 // Surah Number
//                 Container(
//                   width: 56,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Color(0xFF059669),
//                         Color(0xFF047857),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF059669).withOpacity(0.3),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       surah.number.toArabic(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 16),

//                 // Surah Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         surah.name,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: isDark ? Colors.white : const Color(0xFF1A1A1A),
//                           letterSpacing: 0.2,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: surah.revelationType == 'مكية'
//                                   ? const Color(0xFF3B82F6).withOpacity(0.1)
//                                   : const Color(0xFF8B5CF6).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: surah.revelationType == 'مكية'
//                                     ? const Color(0xFF3B82F6).withOpacity(0.3)
//                                     : const Color(0xFF8B5CF6).withOpacity(0.3),
//                               ),
//                             ),
//                             child: Text(
//                               surah.revelationType,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: surah.revelationType == 'مكية'
//                                     ? const Color(0xFF3B82F6)
//                                     : const Color(0xFF8B5CF6),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: isDark 
//                                   ? const Color(0xFF2A2A2A)
//                                   : const Color(0xFFF3F4F6),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Text(
//                               "${surah.ayahs.length.toArabic()} آية",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: isDark 
//                                     ? Colors.white.withOpacity(0.7)
//                                     : const Color(0xFF6B7280),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Arrow
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: isDark 
//                         ? const Color(0xFF2A2A2A)
//                         : const Color(0xFFF9FAFB),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: isDark 
//                         ? Colors.white.withOpacity(0.6)
//                         : const Color(0xFF6B7280),
//                     size: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }