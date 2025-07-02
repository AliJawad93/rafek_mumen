import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'quran_surah_page.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  Future<List<Map<String, dynamic>>> _loadSurahs() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/quran.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final List<dynamic> jsonList = jsonMap['surahs'] as List<dynamic>;
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e, s) {
      debugPrint('Error loading surahs: $e');
      debugPrint('Stack trace: $s');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qur\'an')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadSurahs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load Qur\'an data'));
          }
          final surahs = snapshot.data ?? [];
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: surahs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, idx) {
              final surah = surahs[idx];
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuranSurahPage(surah: surah),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.07),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.15),
                          child: Text(
                            surah['number']?.toString() ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                surah['name'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                surah['english_name'] ?? '',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
