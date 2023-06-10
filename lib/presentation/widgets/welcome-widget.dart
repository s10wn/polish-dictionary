import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/presentation/screens/main-screen.dart';
import 'package:polish_dictionary/presentation/utils/language_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeWidget extends StatefulWidget {
  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  int currentStep = 0;
  String _selectedLanguage = 'Русский';
  final interfaceLanguage = TextEditingController();
  final translateLanguage = TextEditingController();

  Future<void> updateShowWelcomeScreen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('welcome', value);
  }

  List<String> languages = [
    "Русский",
    "Английский",

    // Добавьте остальные языки
  ];
  @override
  Widget build(BuildContext context) {
    updateShowWelcomeScreen(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка приложения'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                switch (orientation) {
                  case Orientation.portrait:
                    return _buildStepper(StepperType.vertical);
                  case Orientation.landscape:
                    return _buildStepper(StepperType.horizontal);
                  default:
                    throw UnimplementedError(orientation.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void selectedLanguage(String value, String type) {
    setState(() {
      _selectedLanguage = value;
    });
    if (value.isEmpty) {
      LanguagePreferences().saveSelectedLanguage("Английский", type);
    }
    LanguagePreferences().saveSelectedLanguage(value, type);
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  Widget getWidgetBasedOnValue(String value) {
    switch (value) {
      case 'Выберите язык интерфейса':
        return CustomDropdown(
          hintText: 'Выберите язык',
          items: languages,
          excludeSelected: false,
          listItemBuilder: (context, result) => ListTile(
            title: Text(result),
          ),
          onChanged: (e) => selectedLanguage(e, "interface"),
          controller: interfaceLanguage,
        );
      case 'Выберите язык перевода':
        return CustomDropdown(
          hintText: 'Выберите язык',
          items: languages,
          excludeSelected: false,
          listItemBuilder: (context, result) => ListTile(
            title: Text(result),
          ),
          onChanged: (e) => selectedLanguage(e, "translate"),
          controller: translateLanguage,
        );

      case 'Завершение':
        return const Text("Поздравляю! Вы завершили настройку приложения");

      default:
        return const Text("Произошла ошибка");
    }
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 3;

    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
      onStepContinue: currentStep < 2
          ? () => setState(() => ++currentStep)
          : goToHomeScreen,
      steps: [
        for (var i = 0; i < 3; ++i)
          _buildStep(
            title: Text(i == 0
                ? 'Выберите язык интерфейса'
                : i == 1
                    ? 'Выберите язык перевода'
                    : 'Завершение'),
            isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep
                    ? StepState.complete
                    : StepState.indexed,
          ),
      ],
    );
  }

  Step _buildStep({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
        title: title,
        state: state,
        isActive: isActive,
        content: title is Text
            ? getWidgetBasedOnValue(title.data!)
            : const Text(""));
  }
}
