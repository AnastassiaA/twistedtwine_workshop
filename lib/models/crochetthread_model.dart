import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CrochetThreadModel {
  //final String? threadNumber;
  final String threadColor;
  //final String image;
  final String brand;
  final String material;
  final String size;
  final double availableWeight;
  final double pricePerGram;
  final double weight;
  final String reccHookNeedle;
  final double cost;

  CrochetThreadModel(
      { //required this.threadNumber,
      required this.threadColor,
      //required this.image,
      required this.brand,
      required this.material,
      required this.size,
      required this.availableWeight,
      required this.pricePerGram,
      required this.weight,
      required this.reccHookNeedle,
      required this.cost});

  Map<String, dynamic> toMap() {
    return {
      //'threadnumber': threadNumber,
      'threadcolor': threadColor,
      //'image': image,
      'brand': brand,
      'material': material,
      'size': size,
      'availableweight': availableWeight,
      'pricepergram': pricePerGram,
      'weight': weight,
      'recchookneedle': reccHookNeedle,
      'cost': cost,
    };
  }

  factory CrochetThreadModel.fromMap(Map<String, dynamic> json) =>
      new CrochetThreadModel(
        //threadNumber: json['threadnumber'],
        threadColor: json['threadcolor'],
        //image: json['image'],
        brand: json['brand'],
        material: json['material'],
        size: json['size'],
        availableWeight: json['availableweight'],
        pricePerGram: json['pricepergram'],
        weight: json['weight'],
        reccHookNeedle: json['recchookneedle'],
        cost: json['cost'],
      );
}

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
