import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/model/specification.dart';
import 'package:gsp23se37_supplier/src/model/specification_custom_request.dart';
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

  static List<SpecificationRequest> getSpecificationRequest({
    required List<Specification> listSpeci,
    required List<TextEditingController> listValue,
    required String selectWeightUnit,
    required String selectLwhUnit,
    required TextEditingController lController,
    required TextEditingController wController,
    required TextEditingController hController,
  }) {
    List<SpecificationRequest> list = [];
    for (var i = 0; i < listSpeci.length; i++) {
      SpecificationRequest specificationRequest = SpecificationRequest(
          specificationID: listSpeci[i].specificationID,
          value: (listSpeci[i].specificationID == 5)
              ? '${lController.text.trim()}x${wController.text.trim()}x${hController.text.trim()} $selectLwhUnit'
              : '${listValue[i].text.trim()}${(listSpeci[i].specificationID == 2) ? ' $selectWeightUnit' : ''}');
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

  static List<SpecificationCustomRequest> getListSpecifiCus(
      {required List<String> specfiName,
      required List<TextEditingController> listValue}) {
    List<SpecificationCustomRequest> list = [];
    for (var i = 0; i < specfiName.length; i++) {
      list.add(SpecificationCustomRequest(
          specificationName: specfiName[i],
          specificationValue: listValue[i].text.trim()));
    }
    return list;
  }

  static void removeNullAndEmptyParams(Map<String, dynamic> mapToEdit) {
// Remove all null values; they cause validation errors
    final keys = mapToEdit.keys.toList(growable: false);
    for (String key in keys) {
      final value = mapToEdit[key];
      if (value == null) {
        mapToEdit.remove(key);
      } else if (value is String) {
        if (value.isEmpty) {
          mapToEdit.remove(key);
        }
      } else if (value is Map<String, dynamic>) {
        removeNullAndEmptyParams(value);
      }
    }
  }
}
