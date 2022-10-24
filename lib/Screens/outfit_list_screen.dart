import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfits/Models/outfit.dart';
import 'package:outfits/Widgets/outfit_list_item.dart';

class OutfitListScreen extends StatefulWidget {
  const OutfitListScreen({super.key});

  @override
  State<OutfitListScreen> createState() => _OutfitListScreenState();
}

class _OutfitListScreenState extends State<OutfitListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Outfit>>(
            stream: Outfit.ref.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Outfit>> snapshot) {
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
                        final outfit =
                            data.docs[index].data();
                        // return ListTile(title: Text(c.name), trailing: svg);
                        return OutfitListItem(outfit: outfit);
                      },
                    ));
              }
              return child;
            }));
  }
}
