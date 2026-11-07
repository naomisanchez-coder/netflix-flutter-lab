import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../widgets/media_widgets.dart';

class CatalogScreen extends StatefulWidget {
  final AppController controller;
  final String initialType;
  const CatalogScreen(this.controller, {super.key, this.initialType = 'Todos'});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final search = TextEditingController();
  late String type = widget.initialType;
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = widget.controller.search(search.text, type);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descubre tu próxima historia',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: search,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Título o género',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      tooltip: 'Limpiar búsqueda',
                      onPressed: () {
                        search.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['Todos', 'Películas', 'Series']
                      .map(
                        (value) => ChoiceChip(
                          label: Text(value),
                          selected: type == value,
                          onSelected: (_) => setState(() => type = value),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  '${results.length} historias disponibles',
                  style: const TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),
        ),
        if (results.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.white38),
                    SizedBox(height: 16),
                    Text('No encontramos coincidencias'),
                    Text(
                      'Prueba otro título o género.',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: SizedBox(
                      width: 52,
                      height: 72,
                      child: MediaImage(item),
                    ),
                    title: Text(item.title),
                    subtitle: Text(
                      '${item.genre}\n${item.year} · ${item.type}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: item,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
