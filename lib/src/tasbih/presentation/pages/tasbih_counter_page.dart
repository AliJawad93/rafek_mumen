import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TasbihCounterPage extends StatefulWidget {
  const TasbihCounterPage({super.key});

  @override
  State<TasbihCounterPage> createState() => _TasbihCounterPageState();
}

class _TasbihCounterPageState extends State<TasbihCounterPage> {
  int _count = 0;

  void _increment() {
    setState(() => _count++);
    HapticFeedback.lightImpact();
  }

  void _reset() {
    setState(() => _count = 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'عداد التسبيح',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,

          // onTap: _increment,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.7),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.13),
                      blurRadius: 32,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.18),
                    width: 2.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$_count',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // OutlinedButton.icon(
              //   onPressed: _reset,
              //   icon: Icon(Icons.refresh, color: colorScheme.primary),
              //   label: Text(
              //     'اعادة التسبيح',
              //     style: TextStyle(color: colorScheme.primary),
              //   ),
              //   style: OutlinedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 24,
              //       vertical: 14,
              //     ),
              //     side: BorderSide(color: colorScheme.primary),
              //     textStyle: theme.textTheme.labelLarge?.copyWith(fontSize: 18),
              //   ),
              // ),
              const SizedBox(height: 32),

              FilledButton.tonalIcon(
                onPressed: _increment,
                icon: Icon(Icons.fingerprint, size: 32),
                label: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  child: Text(
                    'اضغط لزيادة',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _reset,
        icon: Icon(Icons.refresh),
        label: Text('اعادة التسبيح'),
      ),
    );
  }
}
