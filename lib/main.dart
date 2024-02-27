import 'package:flutter/material.dart';
import 'package:quran_app/pages/detail_dzikir.dart';
import 'package:quran_app/pages/detail_screen.dart';
import 'package:quran_app/pages/home_screen.dart';
import 'package:quran_app/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),``
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final idSurah = arguments['id_surah'] as String;
          final surahTitle = arguments['title_surah'] ;
          return DetailScreen(id_surah: idSurah, surah_title: surahTitle);
        },
        DetailDzikir.routeName: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final idDzikir = arguments['id_dzikir'] as String;
          final dzikirTitle = arguments['title_dzikir'] as String;
          return DetailDzikir(id_dzikir: idDzikir, dzikir_title: dzikirTitle);
        }
      },
    );
  }
}
