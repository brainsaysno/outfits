import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';
import 'package:outfits/Widgets/clothing_grid_item.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Clothing>>(
            stream: Clothing.ref.snapshots(),
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
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        final c = data.docs[index].data();
                        // return ListTile(title: Text(c.name), trailing: svg);
                        return ClothingGridItem(
                          clothing: c,
                        );
                      },
                    ));
              }
              return child;
            }));
  }
}
