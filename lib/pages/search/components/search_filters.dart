import 'package:flutter/material.dart';
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
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTagInput(),
              if (widget.controller.selectedTags.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildSelectedTags(),
              ],
              const SizedBox(height: 16),
              _buildPriceRange(),
              const SizedBox(height: 16),
              _buildSortOptions(context),
              const SizedBox(height: 8),
              _buildClearFiltersButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller.tagController,
            decoration: InputDecoration(
              hintText: 'Dodaj tag...',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => widget.controller.addTag(
                      widget.controller.tagController.text,
                    ),
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
          'Opseg cena (po satu): ${widget.controller.minPrice.round()} € - ${widget.controller.maxPrice.round()} €',
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Minimalna cena',
                  border: OutlineInputBorder(),
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
                decoration: const InputDecoration(
                  labelText: 'Maksimalna cena',
                  border: OutlineInputBorder(),
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

  Widget _buildSortOptions(BuildContext context) {
    return Row(
      children: [
        const Text('Sortiraj po: '),
        Expanded(
          child: DropdownButton<String>(
            value: widget.controller.sortBy,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: 'name', child: Text('Imenu')),
              DropdownMenuItem(
                value: 'price_low',
                child: Text('Ceni rastuće'),
              ),
              DropdownMenuItem(
                value: 'price_high',
                child: Text('Ceni opadajuće'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                widget.controller.sortBy = value;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildClearFiltersButton() {
    return Center(
      child: ElevatedButton(
        onPressed: widget.controller.clearFilters,
        child: const Text('Poništi filtere'),
      ),
    );
  }
}
