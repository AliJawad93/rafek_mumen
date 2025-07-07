import 'package:flutter/material.dart';

class ColorSchemeViewer extends StatelessWidget {
  const ColorSchemeViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final colors = <MapEntry<String, Color?>>[
      MapEntry(
        'brightness',
        null,
      ), // brightness is not a Color, skip display or just label
      MapEntry('primary', cs.primary),
      MapEntry('onPrimary', cs.onPrimary),
      MapEntry('primaryContainer', cs.primaryContainer),
      MapEntry('onPrimaryContainer', cs.onPrimaryContainer),
      MapEntry('primaryFixed', cs.primaryFixed),
      MapEntry('primaryFixedDim', cs.primaryFixedDim),
      MapEntry('onPrimaryFixed', cs.onPrimaryFixed),
      MapEntry('onPrimaryFixedVariant', cs.onPrimaryFixedVariant),
      MapEntry('secondary', cs.secondary),
      MapEntry('onSecondary', cs.onSecondary),
      MapEntry('secondaryContainer', cs.secondaryContainer),
      MapEntry('onSecondaryContainer', cs.onSecondaryContainer),
      MapEntry('secondaryFixed', cs.secondaryFixed),
      MapEntry('secondaryFixedDim', cs.secondaryFixedDim),
      MapEntry('onSecondaryFixed', cs.onSecondaryFixed),
      MapEntry('onSecondaryFixedVariant', cs.onSecondaryFixedVariant),
      MapEntry('tertiary', cs.tertiary),
      MapEntry('onTertiary', cs.onTertiary),
      MapEntry('tertiaryContainer', cs.tertiaryContainer),
      MapEntry('onTertiaryContainer', cs.onTertiaryContainer),
      MapEntry('tertiaryFixed', cs.tertiaryFixed),
      MapEntry('tertiaryFixedDim', cs.tertiaryFixedDim),
      MapEntry('onTertiaryFixed', cs.onTertiaryFixed),
      MapEntry('onTertiaryFixedVariant', cs.onTertiaryFixedVariant),
      MapEntry('error', cs.error),
      MapEntry('onError', cs.onError),
      MapEntry('errorContainer', cs.errorContainer),
      MapEntry('onErrorContainer', cs.onErrorContainer),
      MapEntry('surface', cs.surface),
      MapEntry('onSurface', cs.onSurface),
      MapEntry('surfaceDim', cs.surfaceDim),
      MapEntry('surfaceBright', cs.surfaceBright),
      MapEntry('surfaceContainerLowest', cs.surfaceContainerLowest),
      MapEntry('surfaceContainerLow', cs.surfaceContainerLow),
      MapEntry('surfaceContainer', cs.surfaceContainer),
      MapEntry('surfaceContainerHigh', cs.surfaceContainerHigh),
      MapEntry('surfaceContainerHighest', cs.surfaceContainerHighest),
      MapEntry('onSurfaceVariant', cs.onSurfaceVariant),
      MapEntry('outline', cs.outline),
      MapEntry('outlineVariant', cs.outlineVariant),
      MapEntry('shadow', cs.shadow),
      MapEntry('scrim', cs.scrim),
      MapEntry('inverseSurface', cs.inverseSurface),
      MapEntry('onInverseSurface', cs.onInverseSurface),
      MapEntry('inversePrimary', cs.inversePrimary),
      MapEntry('surfaceTint', cs.surfaceTint),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('ColorScheme Colors')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 5,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final name = colors[index].key;
          final color = colors[index].value;

          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black12),
              ),
            ),
            title: Text(name),
          );
        },
      ),
    );
  }
}

class TextThemeViewer extends StatelessWidget {
  const TextThemeViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Map of style names and corresponding TextStyle getters
    final styles = <String, TextStyle?>{
      'displayLarge': textTheme.displayLarge,
      'displayMedium': textTheme.displayMedium,
      'displaySmall': textTheme.displaySmall,
      'headlineLarge': textTheme.headlineLarge,
      'headlineMedium': textTheme.headlineMedium,
      'headlineSmall': textTheme.headlineSmall,
      'titleLarge': textTheme.titleLarge,
      'titleMedium': textTheme.titleMedium,
      'titleSmall': textTheme.titleSmall,
      'bodyLarge': textTheme.bodyLarge,
      'bodyMedium': textTheme.bodyMedium,
      'bodySmall': textTheme.bodySmall,
      'labelLarge': textTheme.labelLarge,
      'labelMedium': textTheme.labelMedium,
      'labelSmall': textTheme.labelSmall,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('TextTheme Font Sizes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: styles.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final name = styles.keys.elementAt(index);
          final style = styles.values.elementAt(index);

          if (style == null) {
            return ListTile(
              title: Text(name),
              subtitle: const Text('No style found'),
            );
          }

          final fontSize = style.fontSize ?? 14;
          final fontWeight = style.fontWeight?.toString() ?? 'normal';
          final color = style.color ?? Colors.black;

          return ListTile(
            title: Text(name),
            subtitle: Text(
              'Font size: $fontSize\nWeight: $fontWeight\nColor: ${colorToHex(color)}',
              style: style,
            ),
          );
        },
      ),
    );
  }

  String colorToHex(Color color) =>
      '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
