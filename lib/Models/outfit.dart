import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';

@immutable
class Outfit {
  final String name;
  final Clothing headwear;
  final Clothing top;
  final Clothing bottom;

  const Outfit(this.name, this.headwear, this.top, this.bottom);

  Outfit.fromJson(Map<String, dynamic> json)
      : this(
          json['name']! as String,
          Clothing.fromJson(json['headwear']!),
          Clothing.fromJson(json['top']!),
          Clothing.fromJson(json['bottom']!),
        );

      Map<String, dynamic> toJson() {
    return {'name': name, 'headwear': headwear.toJson(), 'top': top.toJson(), 'bottom': bottom.toJson()};
  }

  static final ref = FirebaseFirestore.instance
      .collection('outfits').withConverter<Outfit>(
    fromFirestore: ((snapshot, options) {
      return Outfit.fromJson(snapshot.data()!);
    }),
  toFirestore: ((outfit, options) => outfit.toJson()));
}
