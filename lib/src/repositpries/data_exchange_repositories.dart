import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/data_exchange/data_exchange.dart';
import 'package:gsp23se37_supplier/src/model/data_exchange/data_exchange_search.dart';

import '../model/api_response.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;
import 'api_setting.dart';
import 'app_url.dart';

class DataExchangeRepositories {
  static Future<ApiResponse> getOrders(
      {required DataExchangeSearch dataSearch, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = dataSearch.toMap();
      Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      // final queryParams = orderSearch.toMap();
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getDataExchange}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<DataExchange>.from((body['data'] as List)
              .map<DataExchange>(
                  (x) => DataExchange.fromMap(x as Map<String, dynamic>)));
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
