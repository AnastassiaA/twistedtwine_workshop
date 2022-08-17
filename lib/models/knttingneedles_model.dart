import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class KnittingNeedleModel {
  final String knittingNeedleSize;
  final String knittingNeedleType;

  KnittingNeedleModel(
      {required this.knittingNeedleSize, required this.knittingNeedleType});

  Map<String, dynamic> toMap() {
    return {
      'knittingneedlesize': knittingNeedleSize,
      'knittingneedletype': knittingNeedleType
    };
  }

  factory KnittingNeedleModel.fromMap(Map<String, dynamic> json) =>
      new KnittingNeedleModel(
          knittingNeedleSize: json['knittingneedlesize'],
          knittingNeedleType: json['knittingneedletype']);
}
