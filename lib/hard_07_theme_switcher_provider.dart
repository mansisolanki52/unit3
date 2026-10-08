import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Hard07ThemeSwitcherApp extends StatelessWidget {
  const Hard07ThemeSwitcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Theme Switcher Demo',
            theme: ThemeData.light(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: themeNotifier.themeMode,
            home: const ThemeSwitcherHomeScreen(),
          );
        },
      ),
    );
  }
}

class ThemeSwitcherHomeScreen extends StatelessWidget {
  const ThemeSwitcherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 7: Dark/Light Mode Switcher'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                themeNotifier.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 80,
                color: themeNotifier.isDarkMode ? Colors.amber : Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                themeNotifier.isDarkMode
                    ? 'Dark Mode Active'
                    : 'Light Mode Active',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Toggle Dark Mode',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Switch(
                        value: themeNotifier.isDarkMode,
                        onChanged: (val) {
                          context.read<ThemeNotifier>().toggleTheme(val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
