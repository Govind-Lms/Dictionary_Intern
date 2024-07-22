import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_dictionary/src/core/model/word_model.dart';
import 'package:intern_dictionary/src/const/app_theme.dart';
import 'package:intern_dictionary/src/presentation/view/dashboard/dashboard.dart';
import 'package:path_provider/path_provider.dart';

// import 'dart:async';
// import 'package:local_auth/local_auth.dart';



void main() async{
  await setUp();
  runApp(const ProviderScope(child:  MyApp()));
}

  setUp() async{
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffFFF2D7),
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
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