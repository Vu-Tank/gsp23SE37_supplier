import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/brand.dart';
import 'package:http/http.dart' as http;
import 'api_setting.dart';
import 'app_url.dart';

class BrandRepositories {
  static Future<ApiResponse> getBrands() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(Uri.parse(AppUrl.getBrand), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          List<Brand> list = [
            Brand(brandID: -1, name: 'Chọn hãng Xe được hỗ trợ', listModel: []),
          ];
          list.addAll(List<Brand>.from((body['data'] as List).map<Brand>(
            (x) => Brand.fromMap(x as Map<String, dynamic>),
          )));
          apiResponse.data = list;
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }
}
