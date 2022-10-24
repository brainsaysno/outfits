import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';
import 'package:outfits/Widgets/clothing_grid_item.dart';

class ClothingGrid extends StatelessWidget {
  const ClothingGrid({super.key, required this.stream, this.onTap, this.crossAxisCount = 3, this.itemSize = 50});
  final Stream<QuerySnapshot<Clothing>> stream;
  final Function(Clothing)? onTap;
  final int crossAxisCount;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Clothing>>(
        stream: stream,
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
            final querySnapshot = snapshot.requireData;
            child = Container(
                margin: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount),
                  itemCount: querySnapshot.size,
                  itemBuilder: (context, index) {
                    final c = querySnapshot.docs[index].data();
                    return ClothingGridItem(clothing: c, onTap: onTap, size: itemSize);
                  },
                ));
          }
          return child;
        });
  }
}
