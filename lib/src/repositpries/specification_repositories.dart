import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/specification.dart';
import 'package:http/http.dart' as http;
import 'api_setting.dart';
import 'app_url.dart';

class SpecificationRepositories {
  static Future<ApiResponse> getSpecification(
      {required int subCategory}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'sub_CategoryID': subCategory.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getSpecification}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<Specification>.from((body['data'] as List)
              .map<Specification>(
                  (x) => Specification.fromMap(x as Map<String, dynamic>)));
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
