import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TasbihCounterPage extends StatefulWidget {
  const TasbihCounterPage({super.key});

  @override
  State<TasbihCounterPage> createState() => _TasbihCounterPageState();
}

class _TasbihCounterPageState extends State<TasbihCounterPage>
    with SingleTickerProviderStateMixin {
  int _count = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() async {
    await _controller.forward();
    await _controller.reverse();
    setState(() => _count++);
    HapticFeedback.lightImpact();
  }

  void _reset() {
    setState(() => _count = 0);
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'عداد التسبيح',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Amiri',
                fontSize: 28,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Tasbih Counter',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary.withOpacity(0.7),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.13),
                            blurRadius: 32,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.18),
                          width: 2.5,
                        ),
                        // Glassmorphic effect
                        backgroundBlendMode: BlendMode.luminosity,
                      ),
                      child: Text(
                        '$_count',
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'سُبْحَانَ اللّٰه',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFamily: 'Amiri',
                      fontSize: 26,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              // Large increment FAB at bottom center
              Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Center(
                  child: FloatingActionButton.extended(
                    onPressed: _increment,
                    icon: const Icon(Icons.fingerprint, size: 32),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Tap to Count',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
