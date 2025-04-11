import 'dart:io';

import 'package:flutter/foundation.dart';

class ImageUploadController extends ChangeNotifier {
  final List<File> _images = [];

  List<File> get images => List.unmodifiable(_images);

  void add(File file) {
    _images.add(file);
    notifyListeners();
  }

  void remove(File file) {
    _images.remove(file);
    notifyListeners();
  }

  void clear() {
    _images.clear();
    notifyListeners();
  }
}
