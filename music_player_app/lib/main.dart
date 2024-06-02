import 'package:flutter/material.dart';
import 'package:music_player_app/models/playlist.dart';
import 'package:music_player_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'package:music_player_app/screen/login.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => Playlist()),
          ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

