import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/cat.dart';
import '../screens/cat_details_screen.dart';
import '../widgets/like_dislike_button.dart';
import '../services/cat_api_service.dart';

class CatCardScreen extends StatefulWidget {
  const CatCardScreen({super.key});

  @override
  State<CatCardScreen> createState() => _CatCardScreenState();
}

class _CatCardScreenState extends State<CatCardScreen>
    with TickerProviderStateMixin {
  Cat? _currentCat;
  int _likeCount = 0;
  bool _isLoading = false;
  double _dragOffset = 0.0;
  double _dragStart = 0.0;
  final double _swipeThreshold = 100.0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final CatApiService _catApiService = CatApiService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _loadNewCat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadNewCat() async {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _catApiService.getRandomCat();

      if (!mounted) {
        return;
      }

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            _currentCat = Cat.fromJson(data.first as Map<String, dynamic>);
            _isLoading = false;
            _dragOffset = 0.0;
          });
        } else {
          setState(() {
            _currentCat = null;
            _isLoading = false;
            _dragOffset = 0.0;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Не удалось загрузить котика с породой.')),
            );
          }
        }
      } else {
        setState(() {
          _currentCat = null;
          _isLoading = false;
          _dragOffset = 0.0;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Ошибка загрузки котика: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _currentCat = null;
        _isLoading = false;
        _dragOffset = 0.0;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Произошла ошибка при загрузке котика: $e')),
        );
      }
    }
  }

  void _likeCat() {
    setState(() {
      _likeCount++;
      _dragOffset = 0.0;
    });
    _loadNewCat();
  }

  void _dislikeCat() {
    setState(() {
      _dragOffset = 0.0;
    });
    _loadNewCat();
  }

  void _openDetailsScreen(BuildContext context) {
    if (_currentCat != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CatDetailsScreen(cat: _currentCat!)),
      );
    }
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _dragStart = details.globalPosition.dx;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = details.globalPosition.dx - _dragStart;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset > _swipeThreshold) {
      _likeCat();
    } else if (_dragOffset < -_swipeThreshold) {
      _dislikeCat();
    } else {
      setState(() {
        _dragOffset = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KotoTinder'),
      ),
      body: Center(
        child: _isLoading
            ? FadeTransition(
                opacity: _fadeAnimation,
                child: const Icon(
                  Icons.pets,
                  size: 100,
                  color: Colors.blueGrey,
                ),
              )
            : _currentCat == null
                ? const Text('Нет доступных котиков.')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onHorizontalDragStart: _onHorizontalDragStart,
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        onHorizontalDragEnd: _onHorizontalDragEnd,
                        onTap: () => _openDetailsScreen(context),
                        child: Transform.translate(
                          offset: Offset(_dragOffset, 0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Hero(
                                    tag: _currentCat!.id,
                                    child: CachedNetworkImage(
                                      imageUrl: _currentCat!.url ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              if (_currentCat?.breedName != null)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Text(
                                      _currentCat!.breedName!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LikeDislikeButton(
                            icon: Icons.close,
                            onPressed: _dislikeCat,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 50),
                          LikeDislikeButton(
                            icon: Icons.favorite,
                            onPressed: _likeCat,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Likes: $_likeCount',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
      ),
    );
  }
}
