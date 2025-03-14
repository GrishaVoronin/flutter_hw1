import 'package:flutter/material.dart';

class LikeDislikeButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const LikeDislikeButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: color,
        shadowColor: color.withAlpha(128),
        elevation: 10,
      ),
      child: Icon(
        icon,
        size: 40,
        color: Colors.white,
        semanticLabel: icon == Icons.close ? 'Dislike' : 'Like',
      ),
    );
  }
}
