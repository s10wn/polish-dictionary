import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void restartApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    onTap: () => {},
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
              Text(
                "Для разработчиков",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () => {},
                    icons: Icons.delete_outline,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'Удалить избранное',
                    subtitle: "Удалить все слова из избранного",
                  ),
                  SettingsItem(
                    onTap: () => {restartApp()},
                    icons: Icons.restore,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'Сброс',
                    subtitle: "Сброс настроек приложения",
                  ),
                  SettingsItem(
                    onTap: null,
                    icons: Icons.info_outline,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.blueGrey,
                    ),
                    title: 'О приложении',
                    subtitle: "Информация о приложении",
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
