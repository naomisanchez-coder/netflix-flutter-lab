import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../widgets/media_widgets.dart';

class MyNetflixScreen extends StatelessWidget {
  final AppController controller;
  const MyNetflixScreen(this.controller, {super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Text('Mi Netflix', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 24),
      Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/avatar-${AppController.profiles.indexOf(controller.profile!)}.png',
                width: 96,
                height: 96,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              controller.profile!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Text('Mi Lista', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      if (controller.favorites.isEmpty)
        const Card(
          child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              children: [
                Icon(Icons.bookmark_add_outlined, size: 48),
                SizedBox(height: 12),
                Text('Tu próxima historia empieza aquí'),
                SizedBox(height: 8),
                Text(
                  'Agrega películas y series desde Inicio o Detalle.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),
        ),
      ...controller.favorites.map(
        (item) => Card(
          child: ListTile(
            leading: SizedBox(width: 42, height: 64, child: MediaImage(item)),
            title: Text(item.title),
            subtitle: Text(item.genre),
            onTap: () =>
                Navigator.pushNamed(context, '/detail', arguments: item),
            trailing: IconButton(
              tooltip: 'Quitar ${item.title}',
              onPressed: () => controller.toggle(item),
              icon: const Icon(Icons.bookmark_remove_outlined),
            ),
          ),
        ),
      ),
      const SizedBox(height: 24),
      Card(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Cuenta de demostración'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showInfo(
                context,
                'Cuenta de demostración',
                'No hay autenticación, pagos ni datos personales. La lista se conserva únicamente durante esta sesión.',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configuración'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showInfo(
                context,
                'Configuración de demostración',
                'Tema oscuro y tipografías locales. Las imágenes remotas incluyen respaldo local. No se envían preferencias a un servidor.',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.switch_account_outlined),
              title: const Text('Cambiar de perfil'),
              onTap: () {
                controller.clearProfile();
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      const Text(
        'Netflix Flutter Lab · Aplicaciones Multiplataformas',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white38, fontSize: 12),
      ),
    ],
  );
}
