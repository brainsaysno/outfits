import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';
import 'package:outfits/Widgets/clothing_grid.dart';
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
        child: ClothingGrid(stream: Clothing.ref.snapshots()));
  }
}
