import 'package:flutter/material.dart';
import 'Screens/champions_screen.dart';
import 'Services/local_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League of Legends API',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1428), // Ciemny granat
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF091428),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFC8AA6E), // Złoty
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFFC8AA6E)),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC8AA6E),
          surface: Color(0xFF1E2328), // Tło dla kart
        ),
        useMaterial3: true,
      ),
      home: const ChampionsScreen(),
    );
  }
}
