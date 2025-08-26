import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen_stateless.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: HomeScreen());
    return MaterialApp(home: HomeScreenStateless());
  }
}
