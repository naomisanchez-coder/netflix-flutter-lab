class MediaItem {
  final String id,
      title,
      synopsis,
      genre,
      duration,
      type,
      category,
      poster,
      image;
  final int year;
  final bool featured;
  const MediaItem({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.genre,
    required this.duration,
    required this.type,
    required this.category,
    required this.poster,
    required this.image,
    required this.year,
    required this.featured,
  });
  factory MediaItem.fromMap(Map<String, Object> map) => MediaItem(
    id: map['id'] as String,
    title: map['title'] as String,
    synopsis: map['synopsis'] as String,
    genre: map['genre'] as String,
    duration: map['duration'] as String,
    type: map['type'] as String,
    category: map['category'] as String,
    poster: map['poster'] as String,
    image: map['image'] as String,
    year: map['year'] as int,
    featured: map['featured'] as bool,
  );
}
