import 'package:flutter/material.dart';

// TODO: Не использовать переменные root уровня. Лучше использовать класс со статической переменной.
// Переменные root уровня не ограничены каким-либо пространством имён, что может привести к конфликту в названиях
final darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700)),
    dividerColor: Colors.white24,
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
      labelSmall: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14),
      labelMedium: const TextStyle(
          color: Colors.purple, fontWeight: FontWeight.w700, fontSize: 16),
    ));
