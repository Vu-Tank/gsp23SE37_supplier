import 'dart:convert';

import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/item.dart';
import 'package:gsp23se37_supplier/src/model/item/item_detail.dart';
import 'package:gsp23se37_supplier/src/model/item/item_search.dart';
import 'package:gsp23se37_supplier/src/model/item/sub_item.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../utils/utils.dart';
import 'api_setting.dart';
import 'app_url.dart';

class ItemRepositories {
  static Future<ApiResponse> addItem(
      {required String token,
      required String name,
      required String description,
      required int storeID,
      required int subCategoryID,
      required List<XFile> listImage,
      required List<XFile> listSubItemImage,
      required String listSubItem,
      required String listSpecitication,
      required String listModel,
      required String listSpecificationCustom}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var uri = Uri.parse(AppUrl.addItem);

      Map<String, String> headers = {
        // 'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields['Name'] = name;
      request.fields['Description'] = description;
      request.fields['StoreID'] = storeID.toString();
      request.fields['Sub_CategoryID'] = subCategoryID.toString();
      await Future.forEach(listImage, (file) async {
        var length = await file.length();
        request.files.add(http.MultipartFile('List_Image',
            file.readAsBytes().asStream().asBroadcastStream(), length,
            filename: file.name));
      });
      await Future.forEach(listSubItemImage, (file) async {
        var length = await file.length();
        request.files.add(http.MultipartFile('List_SubItem_Image',
            file.readAsBytes().asStream().asBroadcastStream(), length,
            filename: file.name));
      });
      request.fields['List_SubItem'] = listSubItem;
      request.fields['List_Specitication'] = listSpecitication;
      request.fields['ListModel'] = listModel;
      request.fields['List_SpecificationCustom'] = listSpecificationCustom;
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.asBroadcastStream();
        var responseData = await response.stream.bytesToString(utf8);
        var body = json.decode(responseData);
        // response.stream.asBroadcastStream();
        // var reponseData = await http.Response.fromStream(response);
        // var body = json.decode(reponseData.body);
        apiResponse.msg = body['message'];
        apiResponse.isSuccess = body['success'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {}
      } else {
        // var reponseData = await http.Response.fromStream(response);
        // var body = json.decode(reponseData.body);
        apiResponse.msg = response.statusCode.toString();
        apiResponse.isSuccess = false;
      }
    } catch (e) {
      apiResponse.isSuccess = false;
      apiResponse.msg = e.toString();
    }
    return apiResponse;
  }

  // static Future<ApiResponse> getItem(
  //     {required int storeId,
  //     required String token,
  //     required int page,
  //     required String statusID}) async {
  //   ApiResponse apiResponse = ApiResponse();
  //   try {
  //     final queryParams = {
  //       'storeID': storeId.toString(),
  //       'statusID': statusID,
  //       'page': page.toString(),
  //     };
  //     String queryString = Uri(queryParameters: queryParams).query;
  //     final response =
  //         await http.get(Uri.parse('${AppUrl.getItem}?$queryString'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $token',
  //     }).timeout(ApiSetting.timeOut);
  //     if (response.statusCode == 200) {
  //       final body = json.decode(response.body);
  //       apiResponse.isSuccess = body['success'];
  //       apiResponse.msg = body['message'];
  //       apiResponse.totalPage = int.parse(body['totalPage'].toString());
  //       if (apiResponse.isSuccess!) {
  //         apiResponse.data = List<Item>.from((body['data'] as List)
  //             .map<Item>((x) => Item.fromMap(x as Map<String, dynamic>)));
  //       }
  //     } else {
  //       apiResponse.isSuccess = false;
  //       apiResponse.msg = json.decode(response.body)['errors'].toString();
  //     }
  //   } catch (e) {
  //     apiResponse.isSuccess = false;
  //     apiResponse.msg = e.toString();
  //   }
  //   return apiResponse;
  // }

  static Future<ApiResponse> getItemDetail({required int itemID}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'itemID': itemID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getItemDetail}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = ItemDetail.fromMap(body['data']);
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

  static Future<ApiResponse> hiddenItem(
      {required int itemID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'itemID': itemID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .put(Uri.parse('${AppUrl.hiddenItem}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          // apiResponse.data = ItemDetail.fromMap(body['data']);
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

  static Future<ApiResponse> unHiddenItem(
      {required int itemID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'itemID': itemID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .put(Uri.parse('${AppUrl.unHiddenItem}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          // apiResponse.data = ItemDetail.fromMap(body['data']);
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

  static Future<ApiResponse> hiddenSubItem(
      {required int subItemID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'subItemID': subItemID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .put(Uri.parse('${AppUrl.hiddenSubItem}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = SubItem.fromMap(body['data']);
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

  static Future<ApiResponse> unHiddenSubItem(
      {required int subItemID, required String token}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final queryParams = {
        'subItemID': subItemID.toString(),
      };
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .put(Uri.parse('${AppUrl.unHiddenSubItem}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = SubItem.fromMap(body['data']);
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

  static Future<ApiResponse> getItems(
      {required String token, required ItemSearch itemSearch}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = itemSearch.toMap();
      Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getItems}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<Item>.from((body['data'] as List)
              .map<Item>((x) => Item.fromMap(x as Map<String, dynamic>)));
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

  static Future<ApiResponse> updateSubItem(
      {required String token,
      required int subItemID,
      required int amount,
      required double price}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var response = await http
          .put(
            Uri.parse(AppUrl.updateSubItem),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, dynamic>{
              "subItemID": subItemID,
              "amount": amount,
              "price": price,
            }),
          )
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
    } catch (error) {
      apiResponse.isSuccess = false;
      apiResponse.msg = "Lỗi máy chủ";
    }
    return apiResponse;
  }

  static Future<ApiResponse> getItemsHot(
      {required String token, required int storeID}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      Map<String, dynamic> search = {'storeID': storeID, 'hot': true};
      // Utils.removeNullAndEmptyParams(search);
      final queryParams =
          search.map((key, value) => MapEntry(key, value.toString()));
      String queryString = Uri(queryParameters: queryParams).query;
      final response = await http
          .get(Uri.parse('${AppUrl.getItemsHot}?$queryString'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }).timeout(ApiSetting.timeOut);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        apiResponse.isSuccess = body['success'];
        apiResponse.msg = body['message'];
        apiResponse.totalPage = int.parse(body['totalPage'].toString());
        if (apiResponse.isSuccess!) {
          apiResponse.data = List<Item>.from((body['data'] as List)
              .map<Item>((x) => Item.fromMap(x as Map<String, dynamic>)));
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
