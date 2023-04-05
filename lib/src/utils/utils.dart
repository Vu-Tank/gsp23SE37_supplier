import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/model/item/specification.dart';
import 'package:gsp23se37_supplier/src/model/item/specification_custom_request.dart';
import 'package:gsp23se37_supplier/src/model/item/specification_request.dart';
import 'package:intl/intl.dart';

import '../model/item/brand.dart';
import '../model/reveneu.dart';
import 'dart:math';

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
              : (listSpeci[i].specificationID == 2)
                  ? (int.parse(listValue[i].text.trim()).toString() *
                      ((selectWeightUnit == 'kg') ? 1000 : 1))
                  : listValue[i].text.trim()
          // : '${listValue[i].text.trim()}${(listSpeci[i].specificationID == 2) ? ' $selectWeightUnit' : ''}'
          );
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

  static String getTime(String timeString) {
    if (timeString.isEmpty || timeString == '0') {
      return '';
    }
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime time = format.parse(timeString);
    if (now.day == time.day &&
        now.month == time.month &&
        now.year == time.year) {
      return '${time.hour}:${time.minute}';
      // } else if (false) {
      //   return time.weekday.toString();
    } else if (now.year == time.year) {
      return '${time.day} thg ${time.month}';
    } else {
      return '${time.day} thg ${time.month}, ${time.year}';
    }
  }

  static String createFile() {
    DateTime time = DateTime.now();
    String name =
        'ESMP_${time.toString().trim().replaceAllMapped(RegExp(r'\D'), (match) {
      return '';
    })}';
    return name;
  }

  static double findMaxReveneu(List<Reveneu> list) {
    double maxs = 0;
    if (list.isNotEmpty) {
      maxs = list.map<double>((e) => e.amount).reduce(max);
    }
    return maxs;
  }

  static List<String> gennerationYearSelect() {
    List<String> list = ['Chọn năm'];
    int last = DateTime.now().year;
    for (var i = last; i > 2019; i--) {
      list.add(i.toString());
    }
    return list;
  }

  static bool checkEmptyListReveneu(List<Reveneu> list) {
    for (var element in list) {
      if (element.amount != 0) return false;
    }
    return true;
  }

  static String generationStringFormBrand(Brand brand) {
    String text = '';
    text = '$text${brand.name} -';
    for (var i = 1; i < brand.listModel.length; i++) {
      text = ' $text${brand.listModel[i].name}';
      if (i != brand.listModel.length - 1) {
        text = '$text, ';
      } else {
        text = '$text.';
      }
    }
    return text;
  }

  static List<Reveneu> removethisYear(List<Reveneu> list, int year) {
    if (DateTime.now().year == year) {
      list.length = DateTime.now().month;
    }
    return list;
  }
}
