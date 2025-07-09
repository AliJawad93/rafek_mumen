import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafek_mumen/src/bottom_nav/presentation/bottom_nav_bar.dart';
import 'package:rafek_mumen/utils/functions/route.dart';
import 'package:rafek_mumen/utils/services/local_db.dart';

import '../../main.dart';

// Enhanced city data with additional information
class CityData {
  final String name;
  final List<double> coordinates;
  final String region;
  final IconData icon;
  final bool isCapital;

  CityData({
    required this.name,
    required this.coordinates,
    required this.region,
    required this.icon,
    this.isCapital = false,
  });
}

final Map<String, CityData> iraqCitiesData = {
  'بغداد': CityData(
    name: 'بغداد',
    coordinates: [33.3152, 44.3661],
    region: 'بغداد',
    icon: Icons.account_balance,
    isCapital: true,
  ),
  'البصرة': CityData(
    name: 'البصرة',
    coordinates: [30.5101, 47.7839],
    region: 'البصرة',
    icon: Icons.water,
  ),
  'الموصل': CityData(
    name: 'الموصل',
    coordinates: [36.3541, 43.1436],
    region: 'نينوى',
    icon: Icons.location_city,
  ),
  'أربيل': CityData(
    name: 'أربيل',
    coordinates: [36.2021, 44.0054],
    region: 'كردستان',
    icon: Icons.landscape,
  ),
  'السليمانية': CityData(
    name: 'السليمانية',
    coordinates: [35.5613, 45.4375],
    region: 'كردستان',
    icon: Icons.landscape,
  ),
  'كركوك': CityData(
    name: 'كركوك',
    coordinates: [35.4681, 44.3922],
    region: 'كركوك',
    icon: Icons.oil_barrel,
  ),
  'النجف': CityData(
    name: 'النجف',
    coordinates: [32.0026, 44.3434],
    region: 'النجف',
    icon: Icons.mosque,
  ),
  'كربلاء': CityData(
    name: 'كربلاء',
    coordinates: [32.616, 44.0244],
    region: 'كربلاء',
    icon: Icons.mosque,
  ),
  'الرمادي': CityData(
    name: 'الرمادي',
    coordinates: [33.4152, 43.2975],
    region: 'الأنبار',
    icon: Icons.location_city,
  ),
  'الحلة': CityData(
    name: 'الحلة',
    coordinates: [32.4794, 44.4328],
    region: 'بابل',
    icon: Icons.location_city,
  ),
  'الناصرية': CityData(
    name: 'الناصرية',
    coordinates: [31.0364, 46.2627],
    region: 'ذي قار',
    icon: Icons.location_city,
  ),
  'الفلوجة': CityData(
    name: 'الفلوجة',
    coordinates: [33.3559, 43.7844],
    region: 'الأنبار',
    icon: Icons.location_city,
  ),
  'العمارة': CityData(
    name: 'العمارة',
    coordinates: [31.834, 47.1448],
    region: 'ميسان',
    icon: Icons.location_city,
  ),
  'دهوك': CityData(
    name: 'دهوك',
    coordinates: [36.8663, 42.9885],
    region: 'كردستان',
    icon: Icons.landscape,
  ),
  'السماوة': CityData(
    name: 'السماوة',
    coordinates: [31.8457, 44.6291],
    region: 'المثنى',
    icon: Icons.location_city,
  ),
  'الكوت': CityData(
    name: 'الكوت',
    coordinates: [32.5184, 45.833],
    region: 'واسط',
    icon: Icons.location_city,
  ),
  'الرطبة': CityData(
    name: 'الرطبة',
    coordinates: [33.6119, 41.6967],
    region: 'الأنبار',
    icon: Icons.location_city,
  ),
  'سنجار': CityData(
    name: 'سنجار',
    coordinates: [36.3217, 41.8739],
    region: 'نينوى',
    icon: Icons.location_city,
  ),
  'تكريت': CityData(
    name: 'تكريت',
    coordinates: [34.6085, 43.6851],
    region: 'صلاح الدين',
    icon: Icons.location_city,
  ),
  'زاخو': CityData(
    name: 'زاخو',
    coordinates: [36.7333, 42.9833],
    region: 'كردستان',
    icon: Icons.landscape,
  ),
  'بلد': CityData(
    name: 'بلد',
    coordinates: [33.3486, 44.383],
    region: 'صلاح الدين',
    icon: Icons.location_city,
  ),
  'القائم': CityData(
    name: 'القائم',
    coordinates: [34.4359, 41.0089],
    region: 'الأنبار',
    icon: Icons.location_city,
  ),
  'بعقوبة': CityData(
    name: 'بعقوبة',
    coordinates: [33.7476, 44.6054],
    region: 'ديالى',
    icon: Icons.location_city,
  ),
  'الكوفة': CityData(
    name: 'الكوفة',
    coordinates: [32.03, 44.55],
    region: 'النجف',
    icon: Icons.mosque,
  ),
  'الشطرة': CityData(
    name: 'الشطرة',
    coordinates: [32.5325, 45.8205],
    region: 'ذي قار',
    icon: Icons.location_city,
  ),
  'السويرة': CityData(
    name: 'السويرة',
    coordinates: [32.7297, 44.083],
    region: 'واسط',
    icon: Icons.location_city,
  ),
  'الزبير': CityData(
    name: 'الزبير',
    coordinates: [30.4741, 47.8007],
    region: 'البصرة',
    icon: Icons.water,
  ),
  'بيجي': CityData(
    name: 'بيجي',
    coordinates: [34.9209, 43.4886],
    region: 'صلاح الدين',
    icon: Icons.oil_barrel,
  ),
  'الديوانية': CityData(
    name: 'الديوانية',
    coordinates: [31.9927, 44.9251],
    region: 'القادسية',
    icon: Icons.location_city,
  ),
  'العزيزية': CityData(
    name: 'العزيزية',
    coordinates: [31.6363, 44.6183],
    region: 'واسط',
    icon: Icons.location_city,
  ),
  'حلبجة': CityData(
    name: 'حلبجة',
    coordinates: [35.1775, 45.9869],
    region: 'كردستان',
    icon: Icons.landscape,
  ),
  'هيت': CityData(
    name: 'هيت',
    coordinates: [33.6253, 42.8139],
    region: 'الأنبار',
    icon: Icons.location_city,
  ),
  'خانقين': CityData(
    name: 'خانقين',
    coordinates: [34.9827, 44.9538],
    region: 'ديالى',
    icon: Icons.location_city,
  ),
  'كفري': CityData(
    name: 'كفري',
    coordinates: [34.6947, 44.9603],
    region: 'كركوك',
    icon: Icons.location_city,
  ),
};

enum SortOption { alphabetical, region }

class CitySelectorListView extends StatefulWidget {
  const CitySelectorListView({super.key});

  @override
  State<CitySelectorListView> createState() => _CitySelectorListViewState();
}

class _CitySelectorListViewState extends State<CitySelectorListView>
    with TickerProviderStateMixin {
  String _searchQuery = '';
  List<CityData> _filteredCities = [];
  SortOption _sortOption = SortOption.region;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _searchController;
  late Animation<double> _searchAnimation;

  @override
  void initState() {
    super.initState();
    _filteredCities = iraqCitiesData.values.toList();
    _sortCities();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _searchController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _searchAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _searchController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterCities(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCities = iraqCitiesData.values.toList();
        _searchController.reverse();
      } else {
        _filteredCities = iraqCitiesData.values
            .where(
              (city) =>
                  city.name.contains(query) || city.region.contains(query),
            )
            .toList();
        _searchController.forward();
      }
      _sortCities();
    });
  }

  void _sortCities() {
    switch (_sortOption) {
      case SortOption.alphabetical:
        _filteredCities.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.region:
        _filteredCities.sort((a, b) {
          if (a.isCapital && !b.isCapital) return -1;
          if (!a.isCapital && b.isCapital) return 1;
          return a.region.compareTo(b.region);
        });
        break;
    }
  }

  void _toggleSort() {
    setState(() {
      _sortOption = _sortOption == SortOption.alphabetical
          ? SortOption.region
          : SortOption.alphabetical;
      _sortCities();
    });

    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Enhanced App Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: colorScheme.outline.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اختر المحافظة",
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                "${_filteredCities.length} محافظة متاحة",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Sort Button
                        IconButton(
                          onPressed: _toggleSort,
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              _sortOption == SortOption.alphabetical
                                  ? Icons.sort_by_alpha
                                  : Icons.location_on,
                              key: ValueKey(_sortOption),
                            ),
                          ),
                          style: IconButton.styleFrom(
                            foregroundColor: colorScheme.primary,
                            backgroundColor: colorScheme.primaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Enhanced Search Bar
                    Hero(
                      tag: 'search_bar',
                      child: Material(
                        color: Colors.transparent,
                        child: SearchBar(
                          onChanged: _filterCities,
                          hintText: "البحث عن المحافظة أو المنطقة...",
                          leading: AnimatedBuilder(
                            animation: _searchAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 1.0 + (_searchAnimation.value * 0.1),
                                child: Icon(
                                  _searchQuery.isEmpty
                                      ? Icons.search
                                      : Icons.search_off,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              );
                            },
                          ),
                          trailing: _searchQuery.isNotEmpty
                              ? [
                                  AnimatedScale(
                                    scale: _searchAnimation.value,
                                    duration: const Duration(milliseconds: 200),
                                    child: IconButton(
                                      onPressed: () {
                                        _filterCities('');
                                      },
                                      icon: const Icon(Icons.clear),
                                      style: IconButton.styleFrom(
                                        foregroundColor: colorScheme.error,
                                      ),
                                    ),
                                  ),
                                ]
                              : null,
                          backgroundColor: WidgetStateProperty.all(
                            colorScheme.surfaceContainerHigh,
                          ),
                          elevation: WidgetStateProperty.all(0),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                              side: BorderSide(
                                color: colorScheme.outline.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Cities List with enhanced animations
              Expanded(
                child: _isLoading
                    ? _buildLoadingState(colorScheme)
                    : _filteredCities.isEmpty
                    ? _buildEmptyState(context, colorScheme)
                    : _buildCitiesList(context, colorScheme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            "جاري التحميل...",
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.search_off,
              size: 48,
              color: colorScheme.onErrorContainer,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "لا توجد نتائج",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "جرب البحث بكلمة أخرى",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.tonal(
            onPressed: () => _filterCities(''),
            child: const Text("مسح البحث"),
          ),
        ],
      ),
    );
  }

  Widget _buildCitiesList(BuildContext context, ColorScheme colorScheme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredCities.length,
      itemBuilder: (context, index) {
        final city = _filteredCities[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeOutBack,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCityCard(context, city, colorScheme),
          ),
        );
      },
    );
  }

  Widget _buildCityCard(
    BuildContext context,
    CityData city,
    ColorScheme colorScheme,
  ) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: city.isCapital
              ? colorScheme.primary.withOpacity(0.3)
              : colorScheme.outline.withOpacity(0.1),
          width: city.isCapital ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => _selectCity(context, city),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // City Icon
              Hero(
                tag: 'city_icon_${city.name}',
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: city.isCapital
                        ? colorScheme.primary.withOpacity(0.1)
                        : colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    city.icon,
                    color: city.isCapital
                        ? colorScheme.primary
                        : colorScheme.onPrimaryContainer,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // City Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            city.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                          ),
                        ),
                        if (city.isCapital)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "العاصمة",
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      city.region,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onSurfaceVariant,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCity(BuildContext context, CityData city) {
    setState(() {
      _isLoading = true;
    });

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text("تم اختيار ${city.name} بنجاح")),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    // Simulate processing time
    Future.delayed(const Duration(milliseconds: 800), () {
      LocalDatabase.setCitiesCoordinate({city.name: city.coordinates});

      goReplacemnt(const Dashboard());
    });
  }
}

// Enhanced Material 3 dialog with animations
Future<dynamic> showTMDialog({
  required String title,
  String? msg,
  required Icon icon,
  Function()? onDissmiss,
  Widget? view,
}) {
  final context = navigatorKey.currentContext!;
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: colorScheme.surface,
          surfaceTintColor: colorScheme.surfaceTint,
          elevation: 8,
          shadowColor: colorScheme.shadow.withOpacity(0.3),
          titlePadding: const EdgeInsets.all(24),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon.icon,
                  color: colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          content:
              view ??
              (msg != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    )
                  : null),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("موافق"),
            ),
          ],
        ),
      );
    },
  ).then((value) => onDissmiss?.call());
}
