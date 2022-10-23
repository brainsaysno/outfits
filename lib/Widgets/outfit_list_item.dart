import 'package:flutter/material.dart';
import 'package:outfits/Models/outfit.dart';
import 'package:outfits/Screens/outfit_detail_screen.dart';

class OutfitListItem extends StatelessWidget {
  const OutfitListItem({super.key, required this.outfit});
  final Outfit outfit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(outfit.name),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => OutfitDetailScreen(outfit: outfit),
            settings: RouteSettings(name: '/outfit/${outfit.name}'))));
  }
}
