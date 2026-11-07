import '../models/media_item.dart';

// Lista de mapas de demostración convertida a objetos tipados.
const titles = [
  'Órbita final',
  'La ciudad sumergida',
  'Ecos del mañana',
  'Ruta austral',
  'El último faro',
  'Código niebla',
  'Días de verano',
  'Bosque secreto',
  'Horizonte rojo',
  'Café de medianoche',
  'Planeta azul',
  'Entre estaciones',
  'La expedición',
  'Frecuencia cero',
  'Una nueva mañana',
];
const genres = [
  'Ciencia ficción',
  'Aventura',
  'Suspenso',
  'Documental',
  'Drama',
];
final List<Map<String, Object>> catalogMaps = List.generate(
  15,
  (i) => {
    'id': 'media-$i',
    'title': titles[i],
    'genre': genres[i % genres.length],
    'year': 2022 + i % 5,
    'duration': i.isEven ? '${95 + i * 3} min' : '${1 + i % 3} temporadas',
    'type': i.isEven ? 'Películas' : 'Series',
    'category': i % 3 == 0 ? 'Tendencias' : 'Populares',
    'featured': i == 0,
    'poster': 'assets/images/poster-${i % 5}.png',
    'image':
        'https://images.unsplash.com/${photoIds[i % 5]}?auto=format&fit=crop&w=1200&q=80',
    'synopsis':
        '${titles[i]} sigue a un grupo de exploradores que debe elegir entre volver a casa y descubrir una verdad inesperada. Una historia original de ${genres[i % 5].toLowerCase()} sobre la amistad, los límites y las segundas oportunidades.',
  },
);
const photoIds = [
  'photo-1446776811953-b23d57bd21aa',
  'photo-1518837695005-2083093ee35b',
  'photo-1470770841072-f978cf4d019e',
  'photo-1464822759023-fed622ff2c3b',
  'photo-1441974231531-c6227db76b6e',
];
final catalog = List<MediaItem>.unmodifiable(
  catalogMaps.map(MediaItem.fromMap),
);
