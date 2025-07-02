import 'package:flutter/material.dart';

class QuranSurahPage extends StatelessWidget {
  final Map<String, dynamic> surah;

  const QuranSurahPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> ayahs = surah['ayahs'] ?? [];
    return Scaffold(
      appBar: AppBar(title: Text(surah['englishName'] ?? 'Surah')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              surah['name'] ?? '',
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (surah['englishName'] != null)
              Text(
                surah['englishName'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (surah['englishNameTranslation'] != null)
              Text(
                surah['englishNameTranslation'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            if (surah['revelationType'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Revelation: ${surah['revelationType']}'),
              ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text('Ayahs', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: ayahs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, idx) {
                  final ayah = ayahs[idx];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ayah['numberInSurah']?.toString() ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            ayah['text'] ?? '',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
