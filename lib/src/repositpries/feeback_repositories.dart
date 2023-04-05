import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/feedback.dart';

import '../model/api_response.dart';
import 'package:http/http.dart' as http;

import 'api_setting.dart';
import 'app_url.dart';

class FeedbackRepositories {
  static Future<ApiResponse> getItemDetail(
      {required int itemID, required int page, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'itemID': itemID.toString(),
        'page': page.toString(),
        'role': '3',
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getFeedbacksItem}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<FeedBack>.from((body['data'] as List)
              .map<FeedBack>(
                  (x) => FeedBack.fromMap(x as Map<String, dynamic>)));
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
