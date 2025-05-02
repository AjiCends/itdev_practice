import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings_provider.dart';
import 'package:flutter_application_2/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProxyProvider<SettingsProvider, ThemeProvider>(
          create: (context) => ThemeProvider(),
          update: (context, settings, themeProvider) {
            themeProvider ??= ThemeProvider();
            themeProvider.updateTheme(settings.currentTheme);
            return themeProvider; // Kembalikan instance yang sama (atau yang baru dibuat saat awal)
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = context.select<ThemeProvider, ThemeData>(
      (themeProvider) => themeProvider.themeData,
    );
    return MaterialApp(
      title: 'Dynamic Theme App',
      theme: themeData,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan Tema')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Pilih Tema:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => settingsProvider.setTheme(AppTheme.light),
                  child: Text('Terang'),
                ),
                ElevatedButton(
                  onPressed: () => settingsProvider.setTheme(AppTheme.dark),
                  child: Text('Gelap'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}