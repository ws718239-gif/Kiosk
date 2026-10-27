import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/i18n/locale_provider.dart';
import '../../../../core/i18n/app_strings.dart';
import '../../../../core/theme/theme_provider.dart';

class AdminSettingsScreen extends ConsumerWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings = ref.watch(themeSettingsProvider);
    final currentLocale = ref.watch(localeProvider);

    final isDark = themeSettings.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Settings'.tr(context)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Appearance
          _SectionHeader(title: 'Appearance'.tr(context)),
          Card(
            child: SwitchListTile(
              title: Text('Dark Mode'.tr(context)),
              subtitle: Text('Toggle between light and dark theme'.tr(context)),
              value: isDark,
              onChanged: (value) {
                ref.read(themeSettingsProvider.notifier).toggleTheme(value);
              },
            ),
          ),

          const SizedBox(height: 16),

          // Section 2: Localization
          _SectionHeader(title: 'Localization'.tr(context)),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text('Kiosk Language'.tr(context)),
              subtitle: Text('Select the default language'.tr(context)),
              trailing: DropdownButton<String>(
                value: currentLocale.languageCode,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'hi', child: Text('Hindi')),
                  DropdownMenuItem(value: 'gu', child: Text('Gujarati')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    ref.read(localeProvider.notifier).setLocale(value);
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Section 3: Branding
          _SectionHeader(title: 'Branding (Brand Color)'.tr(context)),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ColorPicker(
                color: themeSettings.seedColor,
                onColorChanged: (Color color) {
                  ref.read(themeSettingsProvider.notifier).setBrandColor(color);
                },
                heading: Text(
                  'Select Brand Color'.tr(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subheading: Text(
                  'Select color shade'.tr(context),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                pickersEnabled: const <ColorPickerType, bool>{
                  ColorPickerType.both: false,
                  ColorPickerType.primary: true,
                  ColorPickerType.accent: true,
                  ColorPickerType.bw: false,
                  ColorPickerType.custom: false,
                  ColorPickerType.wheel: true,
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
