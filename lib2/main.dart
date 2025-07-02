import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إسلامي',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF50)),
        fontFamily: 'Arabic', // You would need to add Arabic font
      ),
      home: IslamicHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IslamicHomePage extends StatelessWidget {
  const IslamicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: ListTile(
          leading: const Icon(Icons.location_on, color: Color(0xFF4CAF50)),
          title: const Text(
            'الكربلاء، العراق',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text(
            '٢٣ مايو ٢٠٢٤ م',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
        actions: [
          Column(
            children: [
              Text(
                'رفيق المسلم',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '١٥ شوال ١٤٤٥ هـ',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Prayer Times Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Current Prayer Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'الصلاة القادمة',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              'العصر',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '٣:٤٥ م',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '٥:٤٠ ص',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'الوقت الحالي',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Time Until Next Prayer
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'باقي ١ س ٩ د',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Prayer Times Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPrayerTime('الفجر', '٤:٠٣ ص', false),
                        buildPrayerTime('الظهر', '١١:٤٥ ص', false),
                        buildPrayerTime('العصر', '٣:٤٥ م', true),
                        buildPrayerTime('المغرب', '٦:٢٩ م', false),
                        buildPrayerTime('العشاء', '٧:٥٩ م', false),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Location and Date Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'الكربلاء، العراق',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '١٥ شوال',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.nights_stay,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'القبلة ٥١٩٨',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Hadith Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '٥',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'أحاديث اليوم',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Hadith Carousel
            HadithCarousel(),

            const SizedBox(height: 16), // Space for bottom navigation
            DailyPrayersSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'القرآن'),
          BottomNavigationBarItem(icon: Icon(Icons.mosque), label: 'الصلاة'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'القبلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget buildPrayerTime(String name, String time, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white24,
            shape: BoxShape.circle,
          ),
          child: isActive
              ? const Icon(Icons.check, color: Color(0xFF4CAF50), size: 20)
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget buildHadithCard(String hadithText, String source) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            hadithText,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
          if (source.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bookmark_border,
                      color: Color(0xFF4CAF50),
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'عرض كامل',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  source,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class HadithCarousel extends StatefulWidget {
  const HadithCarousel({super.key});

  @override
  _HadithCarouselState createState() => _HadithCarouselState();
}

class _HadithCarouselState extends State<HadithCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> hadiths = [
    {
      'title': 'فضل صيام رمضان وقيام ليلة القدر',
      'text':
          'عن أبي هريرة رضي الله عنه، عن النبي صلى الله عليه وسلم قال: "من صام رمضان إيماناً واحتساباً غُفر له ما تقدم من ذنبه، ومن قام ليلة القدر إيماناً واحتساباً غُفر له ما تقدم من ذنبه".',
      'source': 'رواه البخاري',
    },
    {
      'title': 'أهمية طاعة الزوجة لزوجها',
      'text':
          'عن أبي هريرة رضي الله عنه قال: قال رسول الله صلى الله عليه وسلم: "إذا دعا الرجل زوجته إلى فراشه فأبت فبات غضبان عليها، لعنتها الملائكة حتى تصبح".',
      'source': 'رواه البخاري',
    },
    {
      'title': 'صفات المسلم الحق والمهاجر',
      'text':
          'عن عبد الله بن عمرو رضي الله عنهما قال: قال رسول الله صلى الله عليه وسلم: "المسلم من سلم المسلمون من لسانه ويده، والمهاجر من هجر ما نهى الله عنه".',
      'source': 'رواه البخاري',
    },
    {
      'title': 'أخوة المؤمنين وتماسكهم',
      'text':
          'عن أبي موسى الأشعري رضي الله عنه قال: قال رسول الله صلى الله عليه وسلم: "المؤمن للمؤمن كالبنيان يشد بعضه بعضاً".',
      'source': 'رواه مسلم',
    },
    {
      'title': 'الدعاء جوهر العبادة',
      'text':
          'عن النعمان بن بشير رضي الله عنهما قال: سمعت رسول الله صلى الله عليه وسلم يقول: "الدعاء هو العبادة".',
      'source': 'رواه الترمذي',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: hadiths.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Hadith number indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${index + 1} من ${hadiths.length}',
                            style: const TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.format_quote,
                          color: Color(0xFF4CAF50),
                          size: 24,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Hadith title
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF4CAF50).withOpacity(0.1),
                            const Color(0xFF4CAF50).withOpacity(0.05),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          right: BorderSide(
                            color: const Color(0xFF4CAF50),
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        hadiths[index]['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Hadith text
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          hadiths[index]['text']!,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Source and actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Share functionality
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // Bookmark functionality
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF4CAF50,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.bookmark_border,
                                  color: Color(0xFF4CAF50),
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          hadiths[index]['source']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            hadiths.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? const Color(0xFF4CAF50)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Navigation arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (_currentIndex > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _currentIndex > 0
                      ? const Color(0xFF4CAF50)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: _currentIndex > 0 ? Colors.white : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'السابق',
                      style: TextStyle(
                        color: _currentIndex > 0 ? Colors.white : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Text(
              'اسحب للتنقل',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),

            GestureDetector(
              onTap: () {
                if (_currentIndex < hadiths.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _currentIndex < hadiths.length - 1
                      ? const Color(0xFF4CAF50)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'التالي',
                      style: TextStyle(
                        color: _currentIndex < hadiths.length - 1
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: _currentIndex < hadiths.length - 1
                          ? Colors.white
                          : Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DailyPrayersSection extends StatefulWidget {
  const DailyPrayersSection({super.key});

  @override
  _DailyPrayersSectionState createState() => _DailyPrayersSectionState();
}

class _DailyPrayersSectionState extends State<DailyPrayersSection> {
  final List<Map<String, String>> prayers = [
    {
      'title': 'زيارة الإمام المهدي عليه السلام',
      'description':
          'يوم الجمعة وهو يوم صاحب الزّمان (صلوات الله عليه) و باسمه وهو اليوم الذي يظهر فيه (عجّل الله فرجه) . فقل في زيارته (عليه السلام) :السَّلامُ عَلَيكَ يا حُجَّةَ الله في أرضِهِ. السَّلامُ عَلَيكَ يا عَينَ الله في خَلقِهِ. السَّلامُ عَلَيكَ يا نورَ الله الَّذي يَهتَدي بِهِ المُهتَدونَ ويُفَرَّجُ بِهِ عَنِ المُؤمِنينَ. السَّلامُ عَلَيكَ أيُّها المُهَذَّبُ الخائِفُ. السَّلامُ عَلَيكَ أيُّها الوَليُّ النّاصِحُ. السَّلامُ عَلَيكَ يا سَفينَةَ النَّجاةِ. السَّلامُ عَلَيكَ يا عَينَ الحياةِ. السَّلامُ عَلَيكَ صَلّى اللهُ عَلَيكَ وَعَلى آلِ بَيتِكَ الطَّيِّبينَ الطَّاهِرينَ. السَّلامُ عَلَيكَ. عَجَّلَ الله لَكَ ما وَعَدَكَ مِنَ النَّصرِ وَظُهورِ الأمرِ . السَّلامُ عَلَيكَ يا مَولايَ أنا مَولاكَ عَارِفٌ بِأُولاكَ واُخراكَ. أتَقَرَّبُ إلى اللهِ تَعالى بِكَ وَبِآلِ بَيتِكَ. وَأنتَظِرُ ظُهورَكَ وَظُهورَ الحَقِّ عَلى يَدَيكَ. وَأسألُ الله أن يصلّي عَلى مُحَمَّدٍ وَآلِ مُحَمَّدٍ. وَأن يَجعَلَني مِنَ المُنتَظِرينَ لَكَ وَالتَّابِعينَ وَالنَّاصِرينَ لَكَ عَلى أعدائِكَ. وَالمُستَشهَدينَ بَينَ يَدَيكَ في جُملَةِ أوليائِكَ . يا مَولايَ يا صاحِبَ الزَّمانِ. صَلَواتُ الله عَلَيكَ وَعَلى آلِ بَيتِكَ. هذا يَومُ الجُمُعَةِ وَهُوَ يَومُكَ المُتَوَقَّعُ فيهِ ظُهورُكَ. وَالفَرَجُ فيهِ لِلمُؤمِنينَ عَلى يَدَيكَ. وَقَتلُ الكافِرينَ بِسَيفِكَ. وَأنا يا مَولايَ فيهِ ضَيفُكَ وَجارُكَ. وَأنتَ يا مَولايَ كَريمٌ مِن أولادِ الكِرامِ وَمَأمورٌ بِالضيافَةِ وَالإجارَةِ فَأضِفني وَأجِرني صَلَواتُ الله عَلَيكَ وعَلى أهلِ بَيتِكَ الطَّاهِرينَ.قال السيّد ابن طاووس: وأنا اتمثّل بعد هذه الزيارة بهذا الشعر واُشير إليه (عليه السلام) وأقول:نزيلك حيث ما اتّجهتْ ركابي *** وضيفك حيث كنت من البلادالمصدر:مفاتيح الجنان',
      'source': 'مفاتيح الجنان',
    },
    {
      'title': 'دعاء الصباح',
      'description':
          'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ. رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ.',
      'source': 'القرآن الكريم والسنة',
    },
    {
      'title': 'دعاء دخول المسجد',
      'description':
          'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ. بِسْمِ اللهِ وَالصَّلاةُ وَالسَّلامُ عَلَى رَسُولِ اللهِ.',
      'source': 'السنة النبوية',
    },
    {
      'title': 'دعاء الاستخارة',
      'description':
          'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ، وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ، وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ، فَإِنَّكَ تَقْدِرُ وَلَا أَقْدِرُ، وَتَعْلَمُ وَلَا أَعْلَمُ، وَأَنْتَ عَلَّامُ الْغُيُوبِ.',
      'source': 'صحيح البخاري',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'عرض الكل',
              style: TextStyle(
                color: Color(0xFF4CAF50),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${prayers.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'أدعية اليوم',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Prayers List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prayers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildPrayerCard(prayers[index], index);
          },
        ),
      ],
    );
  }

  Widget _buildPrayerCard(Map<String, String> prayer, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4CAF50).withOpacity(0.2),
                  const Color(0xFF4CAF50).withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(
            prayer['title']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              prayer['source']!,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.right,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF4CAF50),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  right: BorderSide(color: const Color(0xFF4CAF50), width: 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    prayer['description']!,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.8,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildActionButton(Icons.copy, 'نسخ', () {
                            // Copy functionality
                          }),
                          const SizedBox(width: 8),
                          _buildActionButton(Icons.share, 'مشاركة', () {
                            // Share functionality
                          }),
                          const SizedBox(width: 8),
                          _buildActionButton(Icons.favorite_border, 'حفظ', () {
                            // Save functionality
                          }),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.menu_book,
                              color: Color(0xFF4CAF50),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              prayer['source']!,
                              style: const TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 12,
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
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
