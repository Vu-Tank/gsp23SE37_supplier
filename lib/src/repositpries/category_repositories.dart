import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:http/http.dart' as http;
import '../model/category.dart';
import 'api_setting.dart';
import 'app_url.dart';

class CategoryRepositories {
  static Future<ApiResponse> getCategory() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(Uri.parse(AppUrl.getCategory), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          List<Category> list = [
            Category(
                categoryID: -1,
                name: 'Chọn danh mục',
                isActive: true,
                listSub: [])
          ];
          list.addAll(List<Category>.from((body['data'] as List).map<Category>(
            (x) => Category.fromMap(x as Map<String, dynamic>),
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
