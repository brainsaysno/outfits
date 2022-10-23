import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:outfits/Models/clothing.dart';

class ClothingGridItem extends StatelessWidget {
  const ClothingGridItem({super.key, required this.clothing});

  final Clothing clothing;

  @override
  Widget build(BuildContext context) {
    final String graphicName = 'graphics/${clothing.type.getName()}.svg';

    final Widget svg =
        SvgPicture.asset(graphicName, color: clothing.color, height: 50);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        svg,
        Text(
          clothing.name,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
