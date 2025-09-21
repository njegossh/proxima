import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import '../controller.dart';

class SearchFilters extends StatefulWidget {
  final SearchMainController controller;
  final VoidCallback onShowTagSuggestions;

  const SearchFilters({
    super.key,
    required this.controller,
    required this.onShowTagSuggestions,
  });

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  late final TextEditingController minPriceController;
  late final TextEditingController maxPriceController;

  @override
  void initState() {
    minPriceController = TextEditingController(
      text: widget.controller.minPrice.toStringAsFixed(0),
    );
    maxPriceController = TextEditingController(
      text: widget.controller.maxPrice.toStringAsFixed(0),
    );
    super.initState();
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withAlpha(25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader("Tags".tr, Icons.tag),
                const SizedBox(height: 12),
                _buildTagInput(),
                if (widget.controller.selectedTags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildSelectedTags(),
                ],
                const SizedBox(height: 24),
                _buildSectionHeader("Price range".tr, Icons.euro),
                const SizedBox(height: 12),
                _buildPriceRange(),
                const SizedBox(height: 24),
                _buildSectionHeader("Sort".tr, Icons.sort),
                const SizedBox(height: 12),
                _buildSortOptions(theme),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: widget.controller.clearFilters,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Reset filters".tr,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 24, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTagInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller.tagController,
            decoration: InputDecoration(
              hintText: "Add tag".tr,
              filled: true,
              fillColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withAlpha(30),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => widget.controller
                        .addTag(widget.controller.tagController.text),
                  ),
                  IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: widget.onShowTagSuggestions,
                  ),
                ],
              ),
            ),
            onSubmitted: widget.controller.addTag,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedTags() {
    return Wrap(
      spacing: 8,
      children: widget.controller.selectedTags
          .map(
            (tag) => Chip(
              label: Text(tag),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => widget.controller.removeTag(tag),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${"Price range".tr} [${"per hour".tr}]: €${widget.controller.minPrice.round()} - €${widget.controller.maxPrice.round()}",
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Min price".tr,
                  filled: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withAlpha(30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  final min = double.tryParse(value) ?? 0;
                  widget.controller.updatePriceRange(
                    min,
                    widget.controller.maxPrice,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Max price".tr,
                  filled: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withAlpha(30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  final max =
                      double.tryParse(value) ?? widget.controller.maxPrice;
                  widget.controller.updatePriceRange(
                    widget.controller.minPrice,
                    max,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSortOptions(ThemeData theme) {
    return DropdownButton<String>(
      value: widget.controller.sortBy,
      isExpanded: true,
      items: [
        DropdownMenuItem(value: 'name', child: Text("Name".tr)),
        DropdownMenuItem(value: 'price_low', child: Text("Increasing price".tr)),
        DropdownMenuItem(value: 'price_high', child: Text("Decreasing price".tr)),
      ],
      onChanged: (value) {
        if (value != null) widget.controller.sortBy = value;
      },
    );
  }
}
