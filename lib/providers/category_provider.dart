import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  String _mainCategory = '';
  String _subcategory = '';

  String get mainCategory => _mainCategory;
  String get subcategory => _subcategory;

  void setCategories(String mainCategory, String subcategory) {
    _mainCategory = mainCategory;
    _subcategory = subcategory;
    notifyListeners();
  }
}
