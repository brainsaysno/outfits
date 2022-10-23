import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outfits/Models/clothing.dart';
import 'package:outfits/screens/add_clothing.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
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
      title: 'Clothing App',
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
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clothing app"),
      ),
      body: StreamBuilder<QuerySnapshot<Clothing>>(
          stream: Clothing.clothingRef.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Clothing>> snapshot) {
            Widget child = const Text("");
            if (snapshot.connectionState == ConnectionState.waiting) {
              child = const Center(child: Text("Loading..."));
            } else if (snapshot.data?.size == 0) {
              child = const Center(
                child: Text("No clothes, click the button to add one"),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.requireData;
              child = Container(
                  margin: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      final c = data.docs[index].data();
                      final String graphicName =
                          'graphics/${c.type.getName()}.svg';
                      final Widget svg = SvgPicture.asset(graphicName,
                          color: c.color, height: 50);
                      // return ListTile(title: Text(c.name), trailing: svg);
                      return Row(
                          children: [Expanded(child: Text(c.name)), svg]);
                    },
                  ));
            }
            return child;
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const AddClothing(),
                    settings: const RouteSettings(name: '/add_clothing')));
          },
          child: const Icon(Icons.add)),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: "Wardrobe"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Outfits")
      ]),
    );
  }
}
