import 'dart:convert';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../model/address/address.dart';

import '../model/api_response.dart';
import 'api_setting.dart';
import 'app_url.dart';

class UserRepositories {
  static Future<ApiResponse> checkUserExist({required String phone}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {'phone': phone, 'roleID': '2'};
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .post(Uri.parse('${AppUrl.checkExistUser}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          if (body['data'] != 'Supplier') {
            apiResponse.isSuccess = false;
            apiResponse.msg = 'Số điện thoại không hợp lệ';
          }
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

  static Future<ApiResponse> supplierRegister(
      {required String token,
      required String fullName,
      required String email,
      required String phone,
      required String imageName,
      required String imagepath,
      required String contextAddress,
      required String dateOfBirth,
      required String gender,
      required double latitude,
      required double longitude,
      required String province,
      required String district,
      required String ward,
      required String firebaseID,
      required String fcMFirebase}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse(AppUrl.supplierRegister),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "userName": fullName,
          "email": email,
          "phone": phone,
          "imageName": imageName,
          "imagepath": imagepath,
          "contextAddress": contextAddress,
          "dateOfBirth": dateOfBirth,
          "gender": gender,
          "latitude": latitude,
          "longitude": longitude,
          "province": province,
          "district": district,
          "ward": ward,
          "firebaseID": firebaseID,
          "fcM_Firebase": fcMFirebase,
        }),
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          // apiResponse.data = User.fromMap(body['data']);
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

  static Future<ApiResponse> login(
      {required String phone,
      required String fcM_Firebase,
      required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {'phone': phone, 'fcM_Firebase': fcM_Firebase};
      // String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .post(Uri.parse(AppUrl.login),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(queryParams))
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
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

  static Future<ApiResponse> refeshToken(
      {required int userID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'userID': userID.toString(),
        "token": token,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var response = await http.post(
        Uri.parse('${AppUrl.refeshtoken}?$queryString'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
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

  static Future<ApiResponse> logout(
      {required int userID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'userID': userID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var response = await http.post(
        Uri.parse('${AppUrl.logout}?$queryString'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          // apiResponse.data = User.fromMap(body['data']);
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

  static Future<ApiResponse> updateImage({
    required int userID,
    required XFile file,
    required String token,
  }) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var uri = Uri.parse(AppUrl.updateSupplierImage);
      var length = await file.length();
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest('PUT', uri);
      request.headers.addAll(headers);
      request.fields['UserID'] = userID.toString();
      request.files.add(http.MultipartFile(
          'File', file.readAsBytes().asStream().asBroadcastStream(), length,
          filename: file.name));
      var response = await request.send();
      if (response.statusCode == 200) {
        var reponseData = await http.Response.fromStream(response);
        response.stream.asBroadcastStream();
        var body = json.decode(reponseData.body);
        apiResponse.msg = body['message'];
        apiResponse.isSuccess = body['success'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
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

  static Future<ApiResponse> updateUserName(
      {required String userName,
      required String token,
      required int userId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var response = await http
          .put(
            Uri.parse(AppUrl.updateUserName),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              'userID': userId,
              'userName': userName,
            }),
          )
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (error) {
      apiResponse.isSuccess = false;
      apiResponse.msg = "Lỗi máy chủ";
    }
    return apiResponse;
  }

  static Future<ApiResponse> updateUserEmail(
      {required String email,
      required String token,
      required int userId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var response = await http
          .put(
            Uri.parse(AppUrl.updateUserEmail),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              'userID': userId,
              'userEmail': email,
            }),
          )
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (error) {
      apiResponse.isSuccess = false;
      apiResponse.msg = "Lỗi máy chủ";
    }
    return apiResponse;
  }

  static Future<ApiResponse> updateUserGender(
      {required String gender,
      required String token,
      required int userId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var response = await http
          .put(
            Uri.parse(AppUrl.updateUserGender),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              'userID': userId,
              'userGender': gender,
            }),
          )
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (error) {
      apiResponse.isSuccess = false;
      apiResponse.msg = "Lỗi máy chủ";
    }
    return apiResponse;
  }

  static Future<ApiResponse> updateUserDOB(
      {required String dob, required String token, required int userId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var response = await http
          .put(
            Uri.parse(AppUrl.updateUserDOB),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              'UserID': userId,
              'UserBirth': dob,
            }),
          )
          .timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = User.fromMap(body['data']);
        }
      } else {
        apiResponse.isSuccess = false;
        apiResponse.msg = json.decode(response.body)['errors'].toString();
      }
    } catch (error) {
      apiResponse.isSuccess = false;
      apiResponse.msg = "Lỗi máy chủ";
    }
    return apiResponse;
  }

  static Future<ApiResponse> updateUserAddress(
      {required Adderss address,
      required String token,
      required int userId}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var response = await http
          .put(
            Uri.parse(AppUrl.updateUserAddress),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
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
            }),
          )
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
    } catch (error) {
      apiResponse.isSuccess = false;
      apiResponse.msg = "Lỗi máy chủ";
    }
    return apiResponse;
  }
}
