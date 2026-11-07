import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';
import '../widgets/media_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final AppController controller;
  const ProfileScreen(this.controller, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/brand.png', height: 72),
              const SizedBox(height: 16),
              const Text(
                'NETFLIX FLUTTER LAB',
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 32,
                  color: Color(0xffe50914),
                ),
              ),
              const Text(
                'Historias para cada versión de ti.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 40),
              Text(
                '¿Quién está viendo?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 28),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: List.generate(
                  AppController.profiles.length,
                  (i) => SizedBox(
                    width: 112,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        controller.selectProfile(AppController.profiles[i]);
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Column(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'assets/images/avatar-$i.png',
                              width: 104,
                              height: 104,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(AppController.profiles[i]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () => showInfo(
                  context,
                  'Administrar perfiles',
                  'Demostración: hay tres perfiles de prueba. Cada uno mantiene su propia lista durante esta sesión. No se crean cuentas reales.',
                ),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Administrar perfiles'),
              ),
              const SizedBox(height: 32),
              const Text(
                'PROYECTO ACADÉMICO · SIN SUSCRIPCIONES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
