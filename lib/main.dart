import 'package:outfits/Screens/add_clothing_screen.dart';
import 'package:outfits/Screens/outfit_list_screen.dart';
import 'package:outfits/Screens/wardrobe_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
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
    return MaterialApp(
      title: 'Outfits App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = [WardrobeScreen(), OutfitListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outfits app"),
      ),
      body: _screens.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const AddClothingScreen(),
                    settings: const RouteSettings(name: '/add_clothing')));
          },
          child: const Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.checkroom), label: "Wardrobe"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Outfits")
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
      ),
    );
  }
}
