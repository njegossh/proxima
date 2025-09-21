import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
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

    _filterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _filterAnimation = CurvedAnimation(
      parent: _filterAnimationController,
      curve: Curves.easeInOut,
    );

    controller.addListener(() {
      if (mounted) {
        if (controller.showFilters) {
          _filterAnimationController.forward();
        } else {
          _filterAnimationController.reverse();
        }
      }
    });

    // Initial search after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchCourses(controller.searchController.text);
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
              _buildResultsHeader(),
              const SizedBox(height: 8),
              Expanded(child: _buildBody()),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Search".tr),
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
          hintText: "Search courses".tr,
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
          filled: true,
          fillColor: Theme.of(
            context,
          ).colorScheme.surfaceVariant.withValues(alpha: 0.3),
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

  Widget _buildResultsHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: controller.showFilters ? 0 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            child: Text(
              "${"Total courses:".tr} ${controller.filteredCourses.length}",
            ),
          ),
          if (controller.filteredCourses.isNotEmpty)
            TextButton.icon(
              onPressed: controller.clearFilters,
              icon: const Icon(Icons.clear_all, size: 16),
              label: Text("Clear".tr),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                minimumSize: const Size(0, 32),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Loading courses...'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: controller.filteredCourses.isEmpty
          ? _buildEmptyState()
          : _buildCourseList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      key: const ValueKey('empty'),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "No results!".tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try changing filters and try again!".tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: controller.clearFilters,
              icon: const Icon(Icons.refresh),
              label: Text("Reset Filters".tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView.builder(
        key: const ValueKey('list'),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.filteredCourses.length,
        itemBuilder: (context, index) {
          final course = controller.filteredCourses[index];

          // Preload images for first few visible items
          final shouldPreload = index < 3;

          return AnimatedContainer(
            duration: Duration(milliseconds: 100 + (index * 20).clamp(0, 300)),
            curve: Curves.easeOut,
            child: CourseCard(course: course, preloadImage: shouldPreload),
          );
        },
      ),
    );
  }
}
