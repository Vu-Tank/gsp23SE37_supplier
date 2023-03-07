import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/api_response.dart';
import '../model/store.dart';
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
}
