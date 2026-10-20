import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Путеводитель по Осетии',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FBFC),
      ),
      home: const InitialLoader(),
    ),
  );
}

final Color accentUiColor = const Color(0xFF1A434E);

class AlaniaLocation {
  final String imageLink;
  final String title;
  final String zone;
  final String info;

  AlaniaLocation({
    required this.imageLink,
    required this.title,
    required this.zone,
    required this.info,
  });
}

final List<AlaniaLocation> travelSpots = [
  AlaniaLocation(
    imageLink: 'https://avatars.mds.yandex.net/i?id=1b4b317a6164646efb29684dbcc61bc2_l-12997438-images-thumbs&n=13',
    title: 'Гора Казбек',
    zone: 'Кавказский хребет',
    info: 'Потухший стратовулкан, самый восточный пятитысячник Кавказа. Высота составляет 5033 метра. Склоны покрыты вечными ледниками, притягивающими альпинистов со всего мира.',
  ),
  AlaniaLocation(
    imageLink: 'https://avatars.mds.yandex.net/i?id=71bde8394302a819fcfc01dda81967a0_l-7133642-images-thumbs&n=13',
    title: 'Цейское ущелье',
    zone: 'Алагирский район',
    info: 'Жемчужина Северной Осетии. Горнолыжный и альпинистский курорт, окруженный величественными вершинами. Здесь находится один из самых низких ледников Кавказа — Сказский ледник.',
  ),
  AlaniaLocation(
    imageLink: 'https://resize.tripster.ru/8aESeqH8BaePE5yDxa2u8610HSY=/fit-in/800x600/filters:no_upscale()/https://cdn.tripster.ru/photos/c4a48a42-f778-488b-8bee-c24ab630cbf3.jpg',
    title: 'Дигорское ущелье',
    zone: 'Ирафский район',
    info: 'Уединенная и невероятно живописная часть республики. Славится каскадами бурных водородов, альпийскими лугами национального парка Алания и древними родовыми башнями.',
  ),
];

class TypeFilter {
  final String label;
  final IconData visual;

  TypeFilter({required this.label, required this.visual});
}

final List<TypeFilter> sectionFilters = [
  TypeFilter(label: 'Вершины', visual: Icons.filter_hdr),
  TypeFilter(label: 'Водопады', visual: Icons.waterfall_chart),
  TypeFilter(label: 'Ущелья', visual: Icons.landscape),
];

class InitialLoader extends StatefulWidget {
  const InitialLoader({super.key});

  @override
  State<InitialLoader> createState() => _InitialLoaderState();
}

class _InitialLoaderState extends State<InitialLoader> {
  @override
  void initState() {
    super.initState();
    _redirectAfterSplash();
  }

  Future<void> _redirectAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OssetiaExplorerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentUiColor,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.explore, color: Colors.white, size: 80),
                SizedBox(height: 16),
                Text(
                  'АЛАНИЯ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OssetiaExplorerScreen extends StatelessWidget {
  const OssetiaExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ирыстон',
                          style: TextStyle(
                            color: accentUiColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const Text(
                          'Пора в дорогу',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: accentUiColor.withOpacity(0.1),
                      child: Icon(Icons.notifications_none, color: accentUiColor),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search_rounded, color: Colors.grey),
                      SizedBox(width: 12),
                      Text('Поиск красивых мест...', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 24),
                  itemCount: travelSpots.length,
                  itemBuilder: (context, index) {
                    final item = travelSpots[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PlaceDetailView(spot: item),
                          ),
                        );
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 16, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(item.imageLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: Colors.white70, size: 12),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item.zone,
                                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
			),
                       ),
                      );
                     },
                    ),
                   ),
                  ),
	SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Категории локаций',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                    ),
                    Text(
                      'См. все',
                      style: TextStyle(color: accentUiColor, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 24),
                  itemCount: sectionFilters.length,
                  itemBuilder: (context, index) {
                    final filter = sectionFilters[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 12, bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(filter.visual, color: accentUiColor),
                          const SizedBox(width: 8),
                          Text(
                            filter.label,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationPanel(),
    );
  }
}

class PlaceDetailView extends StatelessWidget {
  final AlaniaLocation spot;

  const PlaceDetailView({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(spot.imageLink, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 44,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, color: accentUiColor, size: 18),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spot.title,
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(spot.zone, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetricNode('Доступность', 'На авто / Трек'),
                      _buildMetricNode('Посещение', 'Бесплатно'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Описание маршрута',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        spot.info,
                        style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentUiColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Маршрут построен в навигаторе!')),
                            );
                          },
                          child: const Text('Построить маршрут', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: accentUiColor, width: 2),
                        ),
                        child: Icon(Icons.bookmark_border, color: accentUiColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricNode(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: accentUiColor)),
        ],
      ),
    );
  }
}

class CustomNavigationPanel extends StatefulWidget {
  const CustomNavigationPanel({super.key});

  @override
  State<CustomNavigationPanel> createState() => _CustomNavigationPanelState();
}

class _CustomNavigationPanelState extends State<CustomNavigationPanel> {
  int _currentIndex = 0;

  final List<IconData> _icons = [
    Icons.home_filled,
    Icons.map_outlined,
    Icons.bookmarks_outlined,
    Icons.account_circle_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          final isCurrent = _currentIndex == index;
          return IconButton(
            icon: Icon(
              _icons[index],
              color: isCurrent ? accentUiColor : Colors.grey.shade400,
              size: isCurrent ? 28 : 24,
            ),
            onPressed: () {
              setState(() {
                _currentIndex = index;
              });
            },
          );
        }),
      ),
    );
  }
}
