import 'package:flutter/material.dart';
import './controller.dart';
import './components/course_card.dart';
import './components/search_filters.dart';
import './components/tag_suggestions_dialog.dart';

class SearchMainPage extends StatefulWidget {
  const SearchMainPage({super.key});

  @override
  State<SearchMainPage> createState() => _SearchMainPageState();
}

class _SearchMainPageState extends State<SearchMainPage>
    with TickerProviderStateMixin {
  late SearchMainController controller;
  late AnimationController _filterAnimationController;
  late Animation<double> _filterAnimation;

  @override
  void initState() {
    super.initState();
    controller = SearchMainController();
    controller.searchCourses(controller.searchController.text);

    // Initialize animation controller
    _filterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create slide animation
    _filterAnimation = CurvedAnimation(
      parent: _filterAnimationController,
      curve: Curves.easeInOut,
    );

    // Listen to controller changes to trigger animation
    controller.addListener(() {
      if (controller.showFilters) {
        _filterAnimationController.forward();
      } else {
        _filterAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _filterAnimationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void _showTagSuggestions() {
    TagSuggestionsDialog.show(context, controller);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: Column(
            children: [
              _buildSearchBar(),
              _buildAnimatedFilters(),
              _buildResultsCount(),
              const SizedBox(height: 8),
              _buildCourseList(),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Search'),
      actions: [
        AnimatedBuilder(
          animation: _filterAnimationController,
          builder: (context, child) {
            return IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  controller.showFilters
                      ? Icons.filter_list_off
                      : Icons.filter_list,
                  key: ValueKey(controller.showFilters),
                ),
              ),
              onPressed: () {
                controller.showFilters = !controller.showFilters;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: 'Pretraži kurseve...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.searchController.clear();
                    controller.searchCourses('');
                  },
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onChanged: (value) {
          controller.searchCourses(value);
        },
      ),
    );
  }

  Widget _buildAnimatedFilters() {
    return SizeTransition(
      sizeFactor: _filterAnimation,
      child: FadeTransition(
        opacity: _filterAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.5),
            end: Offset.zero,
          ).animate(_filterAnimation),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SearchFilters(
                  controller: controller,
                  onShowTagSuggestions: _showTagSuggestions,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCount() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: controller.showFilters ? 0 : 8,
      ),
      child: Row(
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.titleSmall!,
            child: Text('Broj kurseva: ${controller.filteredCourses.length}'),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: controller.filteredCourses.isEmpty
            ? const Center(
                key: ValueKey('empty'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Nema pronađenih kurseva',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      'Promenite parameter i pokušajte ponovo',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                key: const ValueKey('list'),
                itemCount: controller.filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = controller.filteredCourses[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 100 + (index * 50)),
                    curve: Curves.easeOut,
                    child: CourseCard(course: course),
                  );
                },
              ),
      ),
    );
  }
}
