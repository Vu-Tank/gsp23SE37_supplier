import 'dart:convert';
import 'package:gsp23se37_supplier/src/model/address/address.dart';
import 'package:gsp23se37_supplier/src/model/cash_flow.dart';
import 'package:gsp23se37_supplier/src/model/cash_flow_search.dart';
import 'package:gsp23se37_supplier/src/model/reveneu.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/api_response.dart';
import '../model/store.dart';
import '../utils/utils.dart';
import 'api_setting.dart';
import 'app_url.dart';

class StoreRepositories {
  static Future<ApiResponse> storeRegister(
      {required int userID,
      required XFile file,
      required String token,
      required String storeName,
      required String email,
      required String phone,
      required String contextAddress,
      required String province,
      required String district,
      required String ward,
      required double latitude,
      required double longitude}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var uri = Uri.parse(AppUrl.registerStore);
      // var streamFile = file.openRead();
      // var stream = http.ByteStream(streamFile);
      // var stream = http.ByteStream(streamFile);
      // stream.cast();
      var length = await file.length();
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields['UserID'] = userID.toString();
      request.fields['StoreName'] = storeName;
      request.fields['Email'] = email;
      request.fields['Phone'] = phone;
      request.fields['Pick_date'] = '1';
      request.fields['contextAddress'] = contextAddress;
      request.fields['Province'] = province;
      request.fields['District'] = district;
      request.fields['Ward'] = ward;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();
      request.files.add(http.MultipartFile(
          'File', file.readAsBytes().asStream().asBroadcastStream(), length,
          filename: file.name));
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.asBroadcastStream();
        var reponseData = await http.Response.fromStream(response);
        var body = json.decode(reponseData.body);
        apiResponse.msg = body['message'];
        apiResponse.isSuccess = body['success'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = Store.fromMap(body['data']);
        }
      } else {
        apiResponse.msg = response.statusCode.toString();
        apiResponse.isSuccess = false;
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }

  static Future<ApiResponse> storeLogin(
      {required int userId, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'userID': userId.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.loginStore}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = Store.fromMap(body['data']);
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

  static Future<ApiResponse> storePayment(
      {required int storeID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'storeID': storeID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.storePayment}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
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

  static Future<ApiResponse> storeWithdrawal(
      {required int storeID,
      required String token,
      required double price,
      required String numBankCart,
      required String ownerBankCart,
      required String bankName}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .post(Uri.parse(AppUrl.storeWithdrawal),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                "storeID": storeID,
                "price": price,
                "numBankCart": numBankCart,
                "ownerBankCart": ownerBankCart,
                "bankName": bankName
              }))
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

  static Future<ApiResponse> storeUpdateInfo(
      {required int storeID,
      XFile? file,
      required String token,
      String? storeName,
      String? email,
      String? phone,
      int? Pick_date}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var uri = Uri.parse(AppUrl.storeUpdate);

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields['StoreID'] = storeID.toString();
      if (storeName != null) {
        request.fields['StoreName'] = storeName;
      }
      if (email != null) {
        request.fields['Email'] = email;
      }
      if (phone != null) {
        request.fields['Phone'] = phone;
      }
      if (Pick_date != null) {
        request.fields['Pick_date'] = '1';
      }
      if (file != null) {
        var length = await file.length();
        request.files.add(http.MultipartFile(
            'File', file.readAsBytes().asStream().asBroadcastStream(), length,
            filename: file.name));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var reponseData = await http.Response.fromStream(response);
        response.stream.asBroadcastStream();
        var body = json.decode(reponseData.body);
        apiResponse.msg = body['message'];
        apiResponse.isSuccess = body['success'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = Store.fromMap(body['data']);
        }
      } else {
        apiResponse.msg = response.statusCode.toString();
        apiResponse.isSuccess = false;
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }

  static Future<ApiResponse> storeCashFlow(
      {required CashFlowSearch cashFlowSearch, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = cashFlowSearch.toMap();
      Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.storeCashFlow}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<CashFlow>.from((body['data'] as List)
              .map<CashFlow>(
                  (x) => CashFlow.fromMap(x as Map<String, dynamic>)));
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

  static Future<ApiResponse> storeReveneu(
      {required int orderID, int? time, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final query = {
        "storeID": orderID,
        "year": time,
      };
      Utils.removeNullAndEmptyParams(query);
      final queryParams =
          query.map((key, value) => MapEntry(key, value.toString()));
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.storeReveneu}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<Reveneu>.from((body['data'] as List)
              .map<Reveneu>((x) => Reveneu.fromMap(x as Map<String, dynamic>)));
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

  static Future<ApiResponse> storeUpdateAddress(
      {required int storeID,
      required String token,
      required Adderss address}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'storeID': storeID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .put(Uri.parse('${AppUrl.updateStoreAddress}?$queryString'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                "addressID": address.addressID,
                "userName": address.userName,
                "phone": address.phone,
                "context": address.context,
                "province": address.province,
                "district": address.district,
                "ward": address.ward,
                "latitude": address.latitude,
                "longitude": address.longitude,
                "isActive": true
              }))
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = Adderss.fromMap(body['data']);
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
