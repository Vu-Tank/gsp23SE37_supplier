import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/model/specification.dart';
import 'package:gsp23se37_supplier/src/model/specification_request.dart';
import 'package:intl/intl.dart';

import '../model/brand.dart';

class Utils {
  static String convertToFirebase(String value) {
    if (value.indexOf('0') == 0) {
      value = value.replaceFirst("0", "+84");
    } else if (value.indexOf("8") == 0) {
      value = value.replaceFirst("8", "+8");
    }
    return value;
  }

  static String convertToDB(String value) {
    if (value.indexOf('0') == 0) {
      value = value.replaceFirst("0", "+84");
    } else if (value.indexOf("8") == 0) {
      value = value.replaceFirst("8", "+8");
    }
    if (value.indexOf('+') == 0) {
      value = value.replaceFirst("+", "");
    }
    return value;
  }

  static String convertDateTimeToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(dateTime);
  }

  static List<SpecificationRequest> getSpecificationRequest(
      {required List<Specification> listSpeci,
      required List<TextEditingController> listValue}) {
    List<SpecificationRequest> list = [];
    for (var i = 0; i < listSpeci.length; i++) {
      SpecificationRequest specificationRequest = SpecificationRequest(
          specificationID: listSpeci[i].specificationID,
          value: listValue[i].text.trim());
      list.add(specificationRequest);
    }
    return list;
  }

  static List<int> getListModel({required List<Brand> listModel}) {
    List<int> list = [];
    for (var element in listModel) {
      for (var model in element.listModel) {
        if (model.isActive) list.add(model.brand_ModelID);
      }
    }
    return list;
  }
}
