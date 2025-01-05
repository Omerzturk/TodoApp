import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false; // Başlangıçta açık tema.

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme; // Tema durumunu değiştir.
    notifyListeners(); // Değişikliği dinleyen widget'lara bildir.
  }
}
