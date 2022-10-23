import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outfits/Models/clothing.dart';

@immutable
class Outfit {
  final String name;
  final Clothing top;
  final Clothing bottom;

  const Outfit(this.name, this.top, this.bottom);

  Outfit.fromJson(dynamic json)
      : this(
          json['name']! as String,
          Clothing.fromJson(json['top']!),
          Clothing.fromJson(json['bottom']!),
        );

  Map<String, dynamic> toJson() {
    return {'name': name, 'top': top.toJson(), 'bottom': bottom.toJson()};
  }

  static final ref = FirebaseFirestore.instance
      .collection('outfits')
      .withConverter<Outfit>(
          fromFirestore: ((snapshot, options) =>
              Outfit.fromJson(snapshot.data()!)),
          toFirestore: ((clothing, options) => clothing.toJson()));
}
