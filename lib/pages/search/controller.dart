import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';

class SearchMainController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  List<Course> _filteredCourses = [];
  List<Course> get filteredCourses => _filteredCourses;

  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  double _minPrice = 0;
  double get minPrice => _minPrice;
  set minPrice(double value) {
    if (_minPrice != value) {
      _minPrice = value;
      _applyFilters();
    }
  }

  double _maxPrice = 100;
  double get maxPrice => _maxPrice;
  set maxPrice(double value) {
    if (_maxPrice != value) {
      _maxPrice = value;
      _applyFilters();
    }
  }

  String _sortBy = 'name';
  String get sortBy => _sortBy;
  set sortBy(String value) {
    if (_sortBy != value) {
      _sortBy = value;
      _applyFilters();
    }
  }

  bool _showFilters = false;
  bool get showFilters => _showFilters;
  set showFilters(bool value) {
    if (_showFilters != value) {
      _showFilters = value;
      notifyListeners();
    }
  }

  Future<void> _applyFilters() async {
    final query = searchController.text.toLowerCase().trim();
    _filteredCourses = await Database().fetchCoursesWithParams( 
      name: query,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      tags: _selectedTags,
    );
    /*
    _filteredCourses = courses.where((course) {
      final matchesName = course.name.toLowerCase().contains(query);
      final matchesPrice =
          course.pricePerHour >= _minPrice && course.pricePerHour <= _maxPrice;
      final matchesTags =
          _selectedTags.isEmpty ||
          _selectedTags.any((tag) => course.tags.contains(tag));

      return matchesName && matchesPrice && matchesTags;
    }).toList();

    if (_sortBy == 'name') {
      _filteredCourses.sort((a, b) => a.name.compareTo(b.name));
    } else if (_sortBy == 'price_low') {
      _filteredCourses.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour));
    } else if (_sortBy == 'price_high') {
      _filteredCourses.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour));
    }
    */

    notifyListeners();
  }

  void addTag(String tag) {
    final lowerTag = tag.trim().toLowerCase();
    if (lowerTag.isNotEmpty && !_selectedTags.any((t) => t.toLowerCase() == lowerTag)) {
      _selectedTags.add(tag);
      tagController.clear();
      _applyFilters();
    }
  }

  void removeTag(String tag) {
    _selectedTags.remove(tag);
    _applyFilters();
  }

  void clearFilters() {
    searchController.clear();
    tagController.clear();
    _selectedTags = [];
    _minPrice = 0;
    _maxPrice = 100;
    _sortBy = 'name';
    _applyFilters();
  }

  void updatePriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    _applyFilters();
  }

  Future<void> searchCourses(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _applyFilters();
  }
  
  List<String> getAllAvailableTags() {
    //TODO Videcemo za ovo kako cemo
    return [];
    //return courses.map((e) => e.tags).expand((element) => element).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    tagController.dispose();
    super.dispose();
  }
}
