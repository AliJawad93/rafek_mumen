import 'package:flutter/material.dart';

class GeneralWorksWidget extends StatelessWidget {
  const GeneralWorksWidget({super.key});

  final List<Map<String, dynamic>> _generalWorks = const [
    {
      'icon': Icons.self_improvement,
      'title': 'Prayer (Salah)',
      'desc': 'Perform the five daily prayers.',
    },
    {
      'icon': Icons.volunteer_activism,
      'title': 'Charity (Sadaqah)',
      'desc': 'Give to those in need.',
    },
    {
      'icon': Icons.handshake,
      'title': 'Kindness',
      'desc': 'Show kindness to others.',
    },
    {
      'icon': Icons.menu_book,
      'title': 'Qur\'an Recitation',
      'desc': 'Read and reflect on the Qur\'an.',
    },
    {
      'icon': Icons.family_restroom,
      'title': 'Family Ties',
      'desc': 'Maintain good relations with family.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General Works',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _generalWorks.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, idx) {
                final work = _generalWorks[idx];
                return Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        work['icon'],
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              work['title'],
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              work['desc'],
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
    );
  }
}
