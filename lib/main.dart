import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/home_page.dart';
import 'screens/diary_deatil.dart';
import 'screens/profile_page.dart';
import 'screens/settings_page.dart';
import 'providers/settings_provider.dart';
import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider()..init(),
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Diary+',
            theme: ThemeData(
              primaryColor: settings.themeColor,
              brightness: settings.isDarkMode ? Brightness.dark : Brightness.light,
              textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: settings.textSize / AppConstants.mediumTextSize,
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/home': (context) => const HomePage(),
              '/diary': (context) => EditNotePage(),
              '/profile': (context) => const ProfilePage(),
              '/settings': (context) => const SettingsPage(),
            },
          );
        },
      ),
    );
  }
}
