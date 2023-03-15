import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/order/order.dart';
import 'package:gsp23se37_supplier/src/model/order/order_search.dart';
import 'package:gsp23se37_supplier/src/model/order/order_ship_status.dart';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';
import 'api_setting.dart';
import 'app_url.dart';

class OrderRepositories {
  static Future<ApiResponse> getOrders(
      {required OrderSearch orderSearch, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = orderSearch.toMap();
      Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      // final queryParams = orderSearch.toMap();
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getOrders}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<Order>.from((body['data'] as List)
              .map<Order>((x) => Order.fromMap(x as Map<String, dynamic>)));
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

  static Future<ApiResponse> getTicket(
      {required int orderID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'orderID': orderID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;

      final response = await http
          .get(Uri.parse('${AppUrl.getTicket}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'AuthorizatiNativeUint8Liston': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          // final List<int> codeUnits = body['data'].codeUnits;
          // final Uint8List unit8List = Uint8List.fromList(codeUnits);
          apiResponse.data = body['data'];
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

  static Future<ApiResponse> getOrderShipStatus(
      {required int orderID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'orderID': orderID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http.get(
          Uri.parse('${AppUrl.getOrderShipStatus}?$queryString'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = OrderShipStatus.fromMap(body['data']);
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
