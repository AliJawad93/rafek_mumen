import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HadithCarousel extends StatefulWidget {
  const HadithCarousel({super.key});

  @override
  State<HadithCarousel> createState() => _HadithCarouselState();
}

class _HadithCarouselState extends State<HadithCarousel> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  final List<Map<String, String>> hadiths = [
    {
      'title': 'فضل صيام رمضان وقيام ليلة القدر',
      'text':
          'من صام رمضان إيماناً واحتساباً غُفر له ما تقدم من ذنبه، ومن قام ليلة القدر إيماناً واحتساباً غُفر له ما تقدم من ذنبه.',
      'source': 'رواه البخاري',
    },
    {
      'title': 'أهمية طاعة الزوجة لزوجها',
      'text':
          'إذا دعا الرجل زوجته إلى فراشه فأبت فبات غضبان عليها، لعنتها الملائكة حتى تصبح.',
      'source': 'رواه البخاري',
    },
    {
      'title': 'صفات المسلم الحق والمهاجر',
      'text':
          'المسلم من سلم المسلمون من لسانه ويده، والمهاجر من هجر ما نهى الله عنه.',
      'source': 'رواه البخاري',
    },
    {
      'title': 'أخوة المؤمنين وتماسكهم',
      'text': 'المؤمن للمؤمن كالبنيان يشد بعضه بعضاً.',
      'source': 'رواه مسلم',
    },
    {
      'title': 'الدعاء جوهر العبادة',
      'text': 'الدعاء هو العبادة.',
      'source': 'رواه الترمذي',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Header
        Row(
          children: [
            Text(
              'اعمال اليوم',
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
                '${hadiths.length}',
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

        const SizedBox(height: 8),

        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: hadiths.length,
          options: CarouselOptions(
            height: 240,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final hadith = hadiths[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${index + 1} من ${hadiths.length}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.format_quote,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.1),
                            theme.colorScheme.primary.withOpacity(0.05),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          right: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        hadith['title']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Text(
                        hadith['text']!,
                        maxLines: 3,
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.share, size: 18),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.bookmark_border,
                                color: theme.colorScheme.primary,
                                size: 18,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Text(
                          hadith['source']!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(hadiths.length, (index) {
            final isActive = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? theme.colorScheme.primary : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
