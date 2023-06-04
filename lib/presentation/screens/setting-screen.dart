import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.red),
                child: Center(child: Text("ADS")),
              ),
              SizedBox(
                height: 50,
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: null,
                    icons: Icons.language_rounded,
                    iconStyle: IconStyle(),
                    title: 'Язык интерфейса',
                    subtitle: "Выберите язык интерфейса",
                  ),
                  SettingsItem(
                    onTap: null,
                    icons: Icons.language_sharp,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Язык перевода',
                    subtitle: "Выберите язык перевода",
                  ),
                  SettingsItem(
                    onTap: null,
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Тема приложения',
                    subtitle: "Automatic",
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: null,
                    icons: Icons.delete_outline,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'Удалить избранное',
                    subtitle: "Удалить все слова из избранного",
                  ),
                ],
              ),
              // You can add a settings title
            ],
          ),
        ),
      ),
    );
  }
}
