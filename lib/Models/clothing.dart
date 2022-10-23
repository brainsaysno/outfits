import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Clothing {
  final String name;
  final ClothingType type;
  final Color color;

  const Clothing(this.name, this.type, this.color);

  Clothing.fromJson(Map<String, dynamic> json)
      : this(
            json['name']! as String,
            ClothingTypeExtension.fromString(json['type']! as String)
                as ClothingType,
            Color.fromARGB(
              255,
              json['color']!['r'] as int,
              json['color']!['g'] as int,
              json['color']!['b'] as int,
            ));

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.getName(),
      'color': {'r': color.red, 'g': color.green, 'b': color.blue}
    };
  }

  static final ref = FirebaseFirestore.instance
      .collection('clothing')
      .withConverter<Clothing>(
          fromFirestore: ((snapshot, options) =>
              Clothing.fromJson(snapshot.data()!)),
          toFirestore: ((clothing, options) => clothing.toJson()));
}

enum ClothingType { top, bottom }

extension ClothingTypeExtension on ClothingType {
  String getName() {
    return toString().split('.').last;
  }

  static ClothingType? fromString(String string) {
    return ClothingType.values
        .firstWhere((ClothingType cT) => cT.getName() == string);
  }
}
