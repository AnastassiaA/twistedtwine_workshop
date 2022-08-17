import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class CrochetHookModel {
  final String hookSize;
  final String hookType;

  CrochetHookModel({required this.hookSize, required this.hookType});

  Map<String, dynamic> toMap() {
    return {'hooksize': hookSize, 'hooktype': hookType};
  }

  factory CrochetHookModel.fromMap(Map<String, dynamic> json) =>
      new CrochetHookModel(
          hookSize: json['hooksize'], hookType: json['hooktype']);
}
