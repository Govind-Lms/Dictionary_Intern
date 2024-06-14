import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_dictionary/model/word_model.dart';
import 'package:intern_dictionary/theme/app_theme.dart';
import 'package:intern_dictionary/ui/dashboard/dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  setUp();
  runApp(const ProviderScope(child: MyApp()));
}

  setUp() async{
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffFFF2D7),
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferences.getInstance();
    await Hive.initFlutter();
    final directory = await getApplicationDocumentsDirectory();
    Hive
      ..init(directory.path)
      ..openBox("favoriteBox")
      ..registerAdapter(WordAdapter())
      ..registerAdapter(MeaningAdapter())
      ..registerAdapter(DefinitionAdapter())
      ..registerAdapter(PhoneticAdapter());
  }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
    );
  }
}