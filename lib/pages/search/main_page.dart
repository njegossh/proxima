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

class _SearchMainPageState extends State<SearchMainPage> {
  late SearchMainController controller;

  @override
  void initState() {
    super.initState();
    controller = SearchMainController();
    controller.searchCourses(controller.searchController.text);
  }

  @override
  void dispose() {
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
              if (controller.showFilters) ...[
                SearchFilters(
                  controller: controller,
                  onShowTagSuggestions: _showTagSuggestions,
                ),
                const SizedBox(height: 16),
              ],
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
        IconButton(
          icon: Icon(
            controller.showFilters ? Icons.filter_list_off : Icons.filter_list,
          ),
          onPressed: () {
            controller.showFilters = !controller.showFilters;
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: (value) {
          controller.searchCourses(value);
        },
      ),
    );
  }

  Widget _buildResultsCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Broj kurseva: ${controller.filteredCourses.length}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return Expanded(
      child: controller.filteredCourses.isEmpty
          ? const Center(
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
              itemCount: controller.filteredCourses.length,
              itemBuilder: (context, index) {
                final course = controller.filteredCourses[index];
                return CourseCard(course: course);
              },
            ),
    );
  }
}