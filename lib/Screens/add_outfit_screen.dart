import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';
import 'package:outfits/Models/outfit.dart';
import 'package:outfits/Widgets/clothing_grid.dart';

class AddOutfitScreen extends StatefulWidget {
  const AddOutfitScreen({super.key});

  @override
  State<AddOutfitScreen> createState() => _AddOutfitScreenState();
}

class _AddOutfitScreenState extends State<AddOutfitScreen> {
  String? _selectedName;
  Clothing? _selectedHeadwear;
  Clothing? _selectedTop;
  Clothing? _selectedBottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Outfit"),
        ),
        body: Padding(padding: EdgeInsets.all(24.0),
            child: Column(
          children: [
          TextField(onChanged: (val) => setState(() => _selectedName = val), decoration: InputDecoration(hintText: "Name"),),
          TextButton(
              child: const Text("Add headwear"),
              onPressed: () => showDialog(
                  context: context,
                  builder: ((ctx) => AlertDialog(
                          title: Text("Choose headwear"),
                          content: SizedBox(
                              width: 200.0,
                              child: ClothingGrid(
                                  onTap: (headwear) => setState(
                                      () => _selectedHeadwear = headwear),
                                  crossAxisCount: 2,
                                  stream: Clothing.ref
                                      .where("type", isEqualTo: "headwear")
                                      .snapshots())),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            )
                          ])))),
          TextButton(
            child: const Text("Add top"),
            onPressed: () => showDialog(
                context: context,
                builder: ((ctx) => AlertDialog(
                        title: Text("Choose top"),
                        content: SizedBox(
                            width: 200.0,
                            child: ClothingGrid(
                                onTap: (top) =>
                                    setState(() => _selectedTop = top),
                                crossAxisCount: 2,
                                stream: Clothing.ref
                                    .where("type", isEqualTo: "top")
                                    .snapshots())),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Confirm'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          )
                        ]))),
          ),
          TextButton(
              child: const Text("Add bottom"),
              onPressed: () => showDialog(
                  context: context,
                  builder: ((ctx) => AlertDialog(
                          title: Text("Choose bottom"),
                          content: SizedBox(
                              width: 200.0,
                              child: ClothingGrid(
                                  onTap: (bottom) =>
                                      setState(() => _selectedBottom = bottom),
                                  crossAxisCount: 2,
                                  stream: Clothing.ref
                                      .where("type", isEqualTo: "bottom")
                                      .snapshots())),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            )
                          ])))),
          ElevatedButton(
              child: Text("Add outfit"),
              onPressed: () {
                Outfit newOutfit = Outfit(_selectedName!, _selectedHeadwear!,
                    _selectedTop!, _selectedBottom!);
                Outfit.ref.add(newOutfit);
                Navigator.of(context).pop();
              })
        ])));
  }
}
