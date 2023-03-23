import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/service/service.dart';
import 'package:gsp23se37_supplier/src/model/service/service_search.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal_search.dart';

import '../model/api_response.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

import 'api_setting.dart';
import 'app_url.dart';

class ServiceRepositorie {
  static Future<ApiResponse> getServiceBuy(
      {required String token, required ServiceSearch searchService}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = searchService.toMap();
      Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getService}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<ServiceBuy>.from((body['data'] as List)
              .map<ServiceBuy>(
                  (x) => ServiceBuy.fromMap(x as Map<String, dynamic>)));
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

  static Future<ApiResponse> getWithdrawals(
      {required String token,
      required WithdrawalSearch withdrawalSearch}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = withdrawalSearch.toMap();
      Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getWithdrawal}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<Withdrawal>.from((body['data'] as List)
              .map<Withdrawal>(
                  (x) => Withdrawal.fromMap(x as Map<String, dynamic>)));
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

  static Future<ApiResponse> cancelService(
      {required String token,
      required String reason,
      required int serviceID}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .put(Uri.parse(AppUrl.cancelService),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({"serviceID": serviceID, "reason": reason}))
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {}
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

  static Future<ApiResponse> acceptService(
      {required String token, required int serviceID}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'serviceID': serviceID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http.put(
        Uri.parse('${AppUrl.accpectService}?$queryString'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {}
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
