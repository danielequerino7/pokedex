import 'package:flutter/material.dart';
import 'package:pokedex/config/config_providers.dart';
import 'package:provider/provider.dart';
import 'telas/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final data = await ConfigureProviders.createDependencyTree();

  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {

  final ConfigureProviders data;

  const MyApp({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        title: "Pokedex",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      )
    );
  }
}