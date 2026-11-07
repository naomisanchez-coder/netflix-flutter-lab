import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../data/catalog.dart';
import '../models/media_item.dart';
import '../widgets/media_widgets.dart';

class HomeScreen extends StatelessWidget {
  final AppController controller;
  final ValueChanged<String> onCatalog;
  const HomeScreen(this.controller, {super.key, required this.onCatalog});
  @override
  Widget build(BuildContext context) {
    final featured = catalog.firstWhere((item) => item.featured);
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset('assets/images/brand.png', height: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Para ${controller.profile}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () => onCatalog('Todos'),
                tooltip: 'Buscar',
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            children: ['Películas', 'Series', 'Todos']
                .map(
                  (type) => ActionChip(
                    label: Text(type == 'Todos' ? 'Categorías' : type),
                    onPressed: () => onCatalog(type),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 460,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MediaImage(featured, remote: true),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xee080808)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'N  ORIGINAL DEL LABORATORIO',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          featured.title.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text('${featured.genre}  •  ${featured.year}  •  13+'),
                        const SizedBox(height: 20),
                        MediaActions(featured, controller),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: featured,
                          ),
                          child: const Text('Más información'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _shelf(
          context,
          'Tendencias',
          catalog.where((i) => i.category == 'Tendencias').toList(),
        ),
        _shelf(
          context,
          'Populares',
          catalog.where((i) => i.category == 'Populares').toList(),
        ),
        _shelf(
          context,
          'Series',
          catalog.where((i) => i.type == 'Series').toList(),
        ),
        _shelf(
          context,
          'Películas',
          catalog.where((i) => i.type == 'Películas').toList(),
        ),
      ],
    );
  }

  Widget _shelf(BuildContext context, String title, List<MediaItem> items) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          SizedBox(
            height: 260,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, index) => const SizedBox(width: 8),
              itemBuilder: (_, index) => PosterCard(items[index]),
            ),
          ),
        ],
      );
}
