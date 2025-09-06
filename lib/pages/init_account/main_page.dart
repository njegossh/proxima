import 'package:flutter/material.dart';
import 'package:proxima/pages/init_account/controller.dart';
import 'components/avatar.dart';

class InitAccountMainPage extends StatefulWidget {
  final bool isInitialized;
  const InitAccountMainPage({super.key, required this.isInitialized});

  @override
  State<InitAccountMainPage> createState() => _InitAccountMainPageState();
}

class _InitAccountMainPageState extends State<InitAccountMainPage> {
  late final InitAccountController controller;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = InitAccountController(isInitialized: widget.isInitialized);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Podesite profil",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 1,
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildAvatarSection(colorScheme),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildFormCard(theme, colorScheme),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatarSection(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Hero(
            tag: 'profile_avatar',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: AvatarWidget(avatarURL: controller.avatarUrlCtrl.text),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.isInitialized ? "Ažuriraj profil" : "Kreiraj profil",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(ThemeData theme, ColorScheme colorScheme) {
    return Card(
      elevation: 2,
      shadowColor: colorScheme.shadow.withAlpha(25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionHeader("Osnovne informacije", Icons.person_outline),
            const SizedBox(height: 20),
            _buildFormFields(),
            const SizedBox(height: 32),
            _buildSectionHeader("Lokacija i preferencije", Icons.location_on_outlined),
            const SizedBox(height: 20),
            _buildLocationSection(theme, colorScheme),
            const SizedBox(height: 32),
            _buildActionButton(theme, colorScheme),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: theme.colorScheme.primary,
        ),
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

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          controller: controller.avatarUrlCtrl,
          label: 'Profilna slika',
          icon: Icons.image_outlined,
          hint: 'URL slike profila',
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: controller.firstNameCtrl,
                label: 'Ime',
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: controller.lastNameCtrl,
                label: 'Prezime',
                icon: Icons.person_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.descriptionCtrl,
          label: 'Opis',
          icon: Icons.description_outlined,
          maxLines: 3,
          hint: 'Opišite sebe u nekoliko reči...',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.locationDescCtrl,
          label: 'Grad i država',
          icon: Icons.location_city_outlined,
          hint: 'npr. Niš, Srbija',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: controller.interestsCtrl,
          label: 'Interesovanja',
          icon: Icons.interests_outlined,
          hint: 'npr. Programiranje, Matematika, Muzika',
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildLocationSection(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.radar,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Radijus pretrage: ${controller.range.toStringAsFixed(0)} km",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 20,
                  ),
                ),
                child: Slider(
                  min: 1,
                  max: 100,
                  divisions: 99,
                  value: controller.range,
                  label: "${controller.range.toStringAsFixed(0)} km",
                  onChanged: (value) {
                    controller.range = value;
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: CheckboxListTile(
            title: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    controller.trackLocation
                        ? Icons.location_on
                        : Icons.location_off,
                    key: ValueKey(controller.trackLocation),
                    color: controller.trackLocation
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Podesi lokaciju?",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Text(
                "Omogućava pronalaženje kurseva u vašoj blizini",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            value: controller.trackLocation,
            onChanged: controller.isInitialized ? controller.trackLocationChange : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(ThemeData theme, ColorScheme colorScheme) {
    return FilledButton(
      onPressed: () {
        controller.updateAccount();
        if (controller.isInitialized) {
          Navigator.pop(context);
        }
        // TODO MARKO: Fix navigation logic
      },
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.isInitialized ? 'Ažuriraj profil' : 'Kreiraj profil',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: 12),
          AnimatedRotation(
            turns: 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              widget.isInitialized ? Icons.update : Icons.arrow_forward,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}