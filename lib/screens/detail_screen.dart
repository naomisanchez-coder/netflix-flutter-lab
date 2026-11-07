import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../data/catalog.dart';
import '../models/media_item.dart';
import '../widgets/media_widgets.dart';

class DetailScreen extends StatelessWidget {
  final MediaItem item;
  final AppController controller;
  const DetailScreen(this.item, this.controller, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Explorar historia')),
    body: ContentWidth(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: MediaImage(item, remote: true),
            ),
          ),
          const SizedBox(height: 24),
          Text(item.title, style: Theme.of(context).textTheme.headlineLarge),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Text('${item.year}'),
              Text(item.duration),
              Text(item.genre),
              const Text(
                '13+ · Ficción de demostración',
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
          const SizedBox(height: 20),
          MediaActions(item, controller),
          const SizedBox(height: 24),
          Text(item.synopsis, style: const TextStyle(height: 1.7)),
          const SizedBox(height: 24),
          Text(
            'Más historias para ti',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: catalog
                  .where(
                    (other) => other.id != item.id && other.genre == item.genre,
                  )
                  .map(PosterCard.new)
                  .toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
