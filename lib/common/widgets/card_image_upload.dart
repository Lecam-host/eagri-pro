import 'dart:io';
import 'package:flutter/material.dart';

class CardImageUpload extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const CardImageUpload({
    super.key,
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Image.file(file, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: onRemove,
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 15,
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
