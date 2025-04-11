import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/image_upload_controller.dart';
import 'card_image_upload.dart';

class ImageUploadWrap extends StatefulWidget {
  final ImageUploadController controller;

  const ImageUploadWrap({super.key, required this.controller});

  @override
  State<ImageUploadWrap> createState() => _ImageUploadWrapState();
}

class _ImageUploadWrapState extends State<ImageUploadWrap> {
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      widget.controller.add(File(picked.path));
    }
  }

  void _confirmRemove(BuildContext context, File file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Confirmation'),
        content:
            const Text('Êtes-vous sûr de vouloir supprimer cette image ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              widget.controller.remove(file);
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.controller.images;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...images.map(
          (file) => CardImageUpload(
            file: file,
            onRemove: () => _confirmRemove(context, file),
          ),
        ),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey.shade200,
            ),
            child: const Icon(Icons.add_a_photo),
          ),
        )
      ],
    );
  }
}
