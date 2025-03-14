import 'breed.dart';

class Cat {
  final String id;
  final String? url;
  final List<Breed>? breeds;

  Cat({
    required this.id,
    this.url,
    this.breeds,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'] ?? '',
      url: json['url'],
      breeds: json['breeds'] != null
          ? (json['breeds'] as List).map((b) => Breed.fromJson(b)).toList()
          : null,
    );
  }

  String? get breedName =>
      breeds?.isNotEmpty == true ? breeds!.first.name : null;
}
