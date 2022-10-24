import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:outfits/Models/outfit.dart';

class OutfitDetailScreen extends StatelessWidget {
  const OutfitDetailScreen({super.key, required this.outfit});
  final Outfit outfit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(outfit.name),
      ),
      body: Center(child: Column(children: <SvgPicture>[outfit.headwear.getSvg(120.0), outfit.top.getSvg(200.0), outfit.bottom.getSvg(200.0)] ))
);
  }
}
