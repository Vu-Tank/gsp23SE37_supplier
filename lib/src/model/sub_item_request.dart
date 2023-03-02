// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SubItemRequest {
  TextEditingController subName;
  TextEditingController subPrice;
  TextEditingController subAmount;
  XFile? image;
  Uint8List? data;
  SubItemRequest({
    required this.subName,
    required this.subPrice,
    required this.subAmount,
    this.image,
    this.data,
  });
}
