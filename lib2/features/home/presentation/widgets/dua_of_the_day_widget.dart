import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuaOfTheDayWidget extends StatefulWidget {
  const DuaOfTheDayWidget({super.key});

  @override
  State<DuaOfTheDayWidget> createState() => _DuaOfTheDayWidgetState();
}

class _DuaOfTheDayWidgetState extends State<DuaOfTheDayWidget>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Map<String, String>>> _duasFuture;

  @override
  void initState() {
    super.initState();
    _duasFuture = _loadFridayDuas();
  }

  Future<List<Map<String, String>>> _loadFridayDuas() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/days_work/fri.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> prais = jsonMap['praies'] ?? [];
    return prais
        .map<Map<String, String>>(
          (item) => {
            'title': item['title'] ?? '',
            'description': item['description'] ?? '',
          },
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return FutureBuilder<List<Map<String, String>>>(
      future: _duasFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('لا يوجد دعاء لهذا اليوم'));
        }
        final duas = snapshot.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Text(
                    'دعاء اليوم',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 8),
                  Text(
                    'المزيد',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DuaOfTheDayMore(duas: duas),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,

                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                itemCount: min(duas.length, 4),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, idx) {
                  final dua = duas[idx];
                  return Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(dua['title'] ?? ''),
                            content: SingleChildScrollView(
                              child: Text(dua['description'] ?? ''),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 16 / 6,
                        child: Container(
                          // width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: theme.colorScheme.primary.withOpacity(0.07),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(
                                  0.08,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: true
                              ? ListTile(
                                  contentPadding: EdgeInsets.zero,

                                  title: Text(
                                    dua['title'] ?? '',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    dua['description'] ?? '',
                                    style: theme.textTheme.bodyMedium,
                                    
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      dua['title'] ?? '',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),

                                    Text(
                                      dua['description'] ?? '',
                                      style: theme.textTheme.bodyMedium,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DuaOfTheDayMore extends StatelessWidget {
  const DuaOfTheDayMore({super.key, required this.duas});

  final List<Map<String, String>> duas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دعاء اليوم')),
      body: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemCount: min(duas.length, 4),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, idx) {
          final dua = duas[idx];
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(dua['title'] ?? ''),
                    content: SingleChildScrollView(
                      child: Text(dua['description'] ?? ''),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.07),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dua['title'] ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dua['description'] ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
