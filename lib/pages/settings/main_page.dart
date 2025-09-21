import 'package:flutter/material.dart';
import 'package:proxima/config/translation.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/settings/controller.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({super.key});

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  final SettingsController controller = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings".tr)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Icon(
                Icons.language,
                size: 30,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              SizedBox(width: 12),
              Text(
                "Language".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 24,),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 280,
                  child: SingleChildScrollView(
                    child: Column(
                      children: controller.languages.entries.map((entry) {
                        final code = entry.key;
                        final name = entry.value['name']!;
                        final flag = entry.value['flag']!;
                        return ListTile(
                          leading: Text(
                            flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(name),
                          trailing: controller.selectedLanguage == code
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            setState(() {
                              controller.selectLanguage(code);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
