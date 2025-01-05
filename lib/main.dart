import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:provider/provider.dart';

import 'package:todo_app/pages/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/theme/theme_notifier.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('missionBox'); // Yapılacaklar için box
  await Hive.openBox('completedBox'); // Tamamlananlar için box
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(), // ThemeNotifier oluştur.
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //tema karanlık ve ayndınlık
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeNotifier.isDarkTheme
          ? AppThemes.darkTheme
          : AppThemes.lightTheme,

      //locasyon tarih ve saat kısmını tr yapmak için
      locale: const Locale('tr'), // Türkçe dil ayarı
      supportedLocales: const [
        Locale('tr'), // Türkçe
        Locale('en', 'US'), // İngilizce (yedeğe almak için)
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,

      home: const HomeScreen(),
    );
  }
}
