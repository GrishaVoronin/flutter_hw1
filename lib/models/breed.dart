class Breed {
  final String? id;
  final String? name;
  final String? description;
  final String? temperament;
  final String? origin;
  final String? lifeSpan;
  final String? wikipediaUrl;

  Breed({
    this.id,
    this.name,
    this.description,
    this.temperament,
    this.origin,
    this.lifeSpan,
    this.wikipediaUrl,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      temperament: json['temperament'],
      origin: json['origin'],
      lifeSpan: json['life_span'],
      wikipediaUrl: json['wikipedia_url'],
    );
  }
}
