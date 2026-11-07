import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netflix_flutter_lab/app/netflix_app.dart';
import 'package:netflix_flutter_lab/controllers/app_controller.dart';
import 'package:netflix_flutter_lab/data/catalog.dart';
import 'package:netflix_flutter_lab/widgets/media_widgets.dart';

void main() {
  test('Catálogo coherente y búsqueda por título, género y tipo', () {
    final state = AppController();
    expect(catalog.length, greaterThanOrEqualTo(15));
    expect(catalog.map((item) => item.id).toSet().length, catalog.length);
    expect(state.search('ÓRBITA', 'Todos').single.title, 'Órbita final');
    expect(state.search('documental', 'Todos'), isNotEmpty);
    expect(
      state.search('', 'Series').every((item) => item.type == 'Series'),
      isTrue,
    );
    expect(state.search('inexistente', 'Todos'), isEmpty);
    state.dispose();
  });

  test('Favoritos aislados por perfil durante la sesión', () {
    final state = AppController();
    state.selectProfile('Naomi');
    state.toggle(catalog.first);
    expect(state.favorites, [catalog.first]);
    state.selectProfile('Alex');
    expect(state.favorites, isEmpty);
    state.selectProfile('Naomi');
    expect(state.isSaved(catalog.first), isTrue);
    state.toggle(catalog.first);
    expect(state.favorites, isEmpty);
    state.dispose();
  });

  for (final width in [320.0, 1440.0]) {
    testWidgets('Navegación, búsqueda y favoritos a ${width.toInt()} px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const NetflixApp());
      await tester.pumpAndSettle();
      expect(find.text('¿Quién está viendo?'), findsOneWidget);
      expect(find.text('Invitado'), findsOneWidget);
      await tester.tap(find.text('Naomi'));
      await tester.pumpAndSettle();
      expect(find.text('Para Naomi'), findsOneWidget);
      Navigator.of(tester.element(find.text('Para Naomi')))
          .pushNamed('/detail', arguments: 'argumento incorrecto');
      await tester.pumpAndSettle();
      expect(find.text('Ruta no disponible'), findsOneWidget);
      await tester.tap(find.text('Volver'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Buscar'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'ÓRBITA');
      await tester.pumpAndSettle();
      expect(find.text('Órbita final'), findsOneWidget);
      await tester.tap(find.text('Órbita final'));
      await tester.pumpAndSettle();
      expect(find.text('Explorar historia'), findsOneWidget);
      await tester.tap(find.text('Mi Lista'));
      await tester.pumpAndSettle();
      expect(find.text('En Mi Lista'), findsOneWidget);
      await tester.tap(find.text('Reproducir'));
      await tester.pumpAndSettle();
      expect(find.text('Reproducción de demostración'), findsOneWidget);
      await tester.tap(find.text('Entendido'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'sin coincidencias');
      await tester.pumpAndSettle();
      expect(find.text('No encontramos coincidencias'), findsOneWidget);
      await tester.tap(find.byTooltip('Limpiar búsqueda'));
      await tester.pumpAndSettle();
      expect(find.text('15 historias disponibles'), findsOneWidget);
      await tester.tap(find.text('Mi Netflix'));
      await tester.pumpAndSettle();
      expect(find.text('Órbita final'), findsOneWidget);
      await tester.tap(find.byTooltip('Quitar Órbita final'));
      await tester.pumpAndSettle();
      expect(find.text('Tu próxima historia empieza aquí'), findsOneWidget);
      await tester.ensureVisible(find.text('Cambiar de perfil'));
      await tester.tap(find.text('Cambiar de perfil'));
      await tester.pumpAndSettle();
      expect(find.text('¿Quién está viendo?'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Imagen remota fallida conserva el respaldo local', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 200,
          height: 300,
          child: MediaImage(catalog.first, remote: true),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Image && widget.image is AssetImage,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
