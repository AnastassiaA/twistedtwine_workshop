import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class OrderModel {
  //final String? orderNumber;
  final String orderName;
  //final String image;
  final String customer;
  final String craftType; //knit or crochet
  //TODO: final timetaken
  final String status;
  final String description;

  OrderModel({
    //required this.orderNumber
    required this.orderName,
    //required this.image
    required this.customer,
    required this.craftType,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      //'ordernumber': orderNumber,
      'ordername': orderName,
      //'image': image,
      'customer': customer,
      'crafttype': craftType,
      'status': status,
      'description': description,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> json) => new OrderModel(
      //orderNumber: json['ordernumber']
      orderName: json['ordername'],
      //image: json['image'],
      customer: json['customer'],
      craftType: json['crafttype'],
      status: json['status'],
      description: json['description']);
}
