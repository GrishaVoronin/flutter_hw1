import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                      tag: cat.id,
                      child: CachedNetworkImage(
                        imageUrl: cat.url ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (cat.breeds != null && cat.breeds!.isNotEmpty) ...[
                Center(
                  child: Text(
                    cat.breeds!.first.name ?? 'Breed unknown',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                if (cat.breeds!.first.description != null)
                  Text(
                    cat.breeds!.first.description!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                const SizedBox(height: 10),
                if (cat.breeds!.first.temperament != null)
                  Text(
                    'Temperament: ${cat.breeds!.first.temperament!}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                const SizedBox(height: 10),
                if (cat.breeds!.first.origin != null)
                  Text(
                    'Origin: ${cat.breeds!.first.origin!}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                const SizedBox(height: 10),
                if (cat.breeds!.first.lifeSpan != null)
                  Text(
                    'Life Span: ${cat.breeds!.first.lifeSpan!}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                const SizedBox(height: 20),
              ] else ...[
                const Text(
                  'Information about breed is not available',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
