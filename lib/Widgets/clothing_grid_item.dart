import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';

class ClothingGridItem extends StatelessWidget {
  const ClothingGridItem(
      {super.key, required this.clothing, this.size = 50.0, this.onTap});
  final Function(Clothing)? onTap;
  final double size;

  final Clothing clothing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap?.call(clothing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            clothing.getSvg(size),
            Text(clothing.name, textAlign: TextAlign.center, style: TextStyle(fontSize: size/3.5))
          ],
        ));
  }
}
