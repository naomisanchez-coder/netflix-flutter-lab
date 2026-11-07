import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../models/media_item.dart';

class MediaImage extends StatelessWidget {
  final MediaItem item;
  final bool remote;
  const MediaImage(this.item, {super.key, this.remote = false});
  @override
  Widget build(BuildContext context) {
    final fallback = Image.asset(
      item.poster,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
    if (!remote) return fallback;
    return Image.network(
      item.image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, error, stack) => fallback,
      loadingBuilder: (_, child, progress) => progress == null
          ? child
          : Stack(
              fit: StackFit.expand,
              children: [
                fallback,
                const Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }
}

class PosterCard extends StatelessWidget {
  final MediaItem item;
  const PosterCard(this.item, {super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 144,
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/detail', arguments: item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MediaImage(item),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Text(
                      'N',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'BebasNeue',
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 12,
                    child: Text(
                      item.title.toUpperCase(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'BebasNeue',
                        fontSize: 26,
                        shadows: [Shadow(blurRadius: 12)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${item.year} · ${item.type}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MediaActions extends StatelessWidget {
  final MediaItem item;
  final AppController controller;
  const MediaActions(this.item, this.controller, {super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        FilledButton.icon(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              icon: const Icon(Icons.play_circle_outline, size: 48),
              title: const Text('Reproducción de demostración'),
              content: Text(
                'Has elegido ${item.title}. Este laboratorio no reproduce video ni requiere una suscripción.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Entendido'),
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Reproducir'),
        ),
        OutlinedButton.icon(
          onPressed: () => controller.toggle(item),
          icon: Icon(controller.isSaved(item) ? Icons.check : Icons.add),
          label: Text(controller.isSaved(item) ? 'En Mi Lista' : 'Mi Lista'),
        ),
      ],
    ),
  );
}

void showInfo(BuildContext context, String title, String message) =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );

class ContentWidth extends StatelessWidget {
  final Widget child;
  const ContentWidth({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: child,
    ),
  );
}
