import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'weather_screen.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/weather': (context) => const WeatherScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const WeatherScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
