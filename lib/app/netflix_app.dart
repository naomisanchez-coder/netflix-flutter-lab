import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../models/media_item.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/catalog_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/my_netflix_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/media_widgets.dart';

class NetflixApp extends StatefulWidget {
  const NetflixApp({super.key});
  @override
  State<NetflixApp> createState() => _NetflixAppState();
}

class _NetflixAppState extends State<NetflixApp> {
  final controller = AppController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => MaterialApp(
      title: 'Netflix Flutter Lab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      onGenerateRoute: (settings) {
        Widget page;
        if (settings.name == '/') {
          page = ProfileScreen(controller);
        } else if (controller.profile == null) {
          page = ProfileScreen(controller);
        } else if (settings.name == '/detail' &&
            settings.arguments is MediaItem) {
          page = DetailScreen(settings.arguments! as MediaItem, controller);
        } else if (settings.name == '/home') {
          page = MainShell(controller);
        } else {
          page = Scaffold(
            appBar: AppBar(title: const Text('Ruta no disponible')),
            body: Builder(
              builder: (routeContext) => Center(
                child: TextButton(
                  onPressed: () {
                    final navigator = Navigator.of(routeContext);
                    if (navigator.canPop()) {
                      navigator.pop();
                    } else {
                      navigator.pushReplacementNamed('/');
                    }
                  },
                  child: const Text('Volver'),
                ),
              ),
            ),
          );
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => page,
        );
      },
    ),
  );
}

class MainShell extends StatefulWidget {
  final AppController controller;
  const MainShell(this.controller, {super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  String type = 'Todos';
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.controller,
    builder: (context, _) => Scaffold(
      body: SafeArea(
        child: ContentWidth(
          child: widget.controller.profile == null
              ? const SizedBox.shrink()
              : switch (index) {
                  0 => HomeScreen(
                    widget.controller,
                    onCatalog: (value) => setState(() {
                      type = value;
                      index = 1;
                    }),
                  ),
                  1 => CatalogScreen(widget.controller, initialType: type),
                  _ => MyNetflixScreen(widget.controller),
                },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() {
          index = value;
          type = 'Todos';
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Mi Netflix',
          ),
        ],
      ),
    ),
  );
}
