import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';

class SearchMainController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  List<Course> _allCourses = [];
  List<Course> _filteredCourses = [];
  List<Course> get filteredCourses => _filteredCourses;

  List<String> _selectedTags = [];
  List<String> get selectedTags => _selectedTags;

  List<String> allAvailableTags = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SearchMainController() {
    init();
  }

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([_loadAllCourses(), fetchAllAvailableTags()]);

    _isLoading = false;
    _applyFiltersLocally();
  }

  Future<void> _loadAllCourses() async {
    try {
      final query = Database().courses.limit(1000);
      final result = await query.get();
      final allCourses = result.docs.map((doc) {
        return Course.fromJson(doc.data() as Map, doc.id);
      }).toList();

      final suspendedSnap = await Database().users
          .where('suspended', isEqualTo: true)
          .get();
      final suspendedIds = suspendedSnap.docs.map((d) => d.id).toSet();

      _allCourses = allCourses
          .where((c) => !suspendedIds.contains(c.userID))
          .toList();
    } catch (e) {
      print('Error loading courses: $e');
      _allCourses = [];
    }
  }

  double _minPrice = 0;
  double get minPrice => _minPrice;
  set minPrice(double value) {
    if (_minPrice != value) {
      _minPrice = value;
      _applyFiltersLocally();
    }
  }

  double _maxPrice = 100;
  double get maxPrice => _maxPrice;
  set maxPrice(double value) {
    if (_maxPrice != value) {
      _maxPrice = value;
      _applyFiltersLocally();
    }
  }

  String _sortBy = 'name';
  String get sortBy => _sortBy;
  set sortBy(String value) {
    if (_sortBy != value) {
      _sortBy = value;
      _applyFiltersLocally();
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

  void _applyFiltersLocally() {
    final query = searchController.text.toLowerCase().trim();

    _filteredCourses = _allCourses.where((course) {
      final matchesName =
          query.isEmpty || course.name.toLowerCase().contains(query);
      final matchesPrice =
          course.pricePerHour >= _minPrice && course.pricePerHour <= _maxPrice;
      final matchesTags =
          _selectedTags.isEmpty ||
          _selectedTags.any((tag) => course.tags.contains(tag));

      return matchesName && matchesPrice && matchesTags;
    }).toList();

    _applySorting();
    notifyListeners();
  }

  void _applySorting() {
    switch (_sortBy) {
      case 'name':
        _filteredCourses.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'price_low':
        _filteredCourses.sort(
          (a, b) => a.pricePerHour.compareTo(b.pricePerHour),
        );
        break;
      case 'price_high':
        _filteredCourses.sort(
          (a, b) => b.pricePerHour.compareTo(a.pricePerHour),
        );
        break;
    }
  }

  Timer? _searchTimer;
  void searchCourses(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 300), () {
      _applyFiltersLocally();
    });
  }

  void addTag(String tag) {
    final lowerTag = tag.trim().toLowerCase();
    if (lowerTag.isNotEmpty &&
        !_selectedTags.any((t) => t.toLowerCase() == lowerTag)) {
      _selectedTags.add(tag);
      tagController.clear();
      _applyFiltersLocally();
    }
  }

  void removeTag(String tag) {
    _selectedTags.remove(tag);
    _applyFiltersLocally();
  }

  void clearFilters() {
    searchController.clear();
    tagController.clear();
    _selectedTags = [];
    _minPrice = 0;
    _maxPrice = 100;
    _sortBy = 'name';
    _applyFiltersLocally();
  }

  void updatePriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    _applyFiltersLocally();
  }

  Future<void> fetchAllAvailableTags() async {
    try {
      final groups = await Database().fetchAllCourseTagGroups();
      allAvailableTags = groups.expand((group) => group.items).toList();
    } catch (e) {
      print('Error loading tags: $e');
      allAvailableTags = [];
    }
  }

  Future<void> refresh() async {
    await _loadAllCourses();
    _applyFiltersLocally();
  }

  // Simple method for scroll-based optimization
  void onScrollNearBottom() {
    // Could implement pagination here if needed
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    searchController.dispose();
    tagController.dispose();
    super.dispose();
  }
}
