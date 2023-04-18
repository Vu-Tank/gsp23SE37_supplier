import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';

import '../../model/order/order_search.dart';
import '../../utils/app_style.dart';
import 'filter_search_order.dart';

Widget searchOrderWidget(
    {required BuildContext context,
    required TextEditingController searchController,
    required OrderSearch orderSearch,
    required Function onSearch}) {
  final formKey = GlobalKey<FormState>();
  String searchType = (orderSearch.orderID != null)
      ? AppConstants.listOrderSearch[1]
      : AppConstants.listOrderSearch[0];
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Form(
      key: formKey,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!orderSearch.isDefault())
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      searchController.text = '';
                      onSearch(orderSearch = OrderSearch(
                          storeID: orderSearch.storeID,
                          page: 1,
                          shipOrderStatus: orderSearch.shipOrderStatus));
                    },
                    icon: const Icon(Icons.arrow_back_outlined)),
              ),
            SizedBox(
              width: 200,
              child: DropdownButtonFormField(
                value: (orderSearch.orderID != null)
                    ? AppConstants.listOrderSearch[1]
                    : AppConstants.listOrderSearch[0],
                icon: const Icon(Icons.arrow_downward),
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppStyle.appColor, width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppStyle.appColor, width: 2),
                      borderRadius: BorderRadius.circular(40)),
                ),
                isExpanded: true,
                elevation: 16,
                style: AppStyle.h2,
                onChanged: (String? value) {
                  if (value != null) {
                    searchType = value;
                  }
                },
                items: AppConstants.listOrderSearch
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: AppStyle.h2,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: TextFormField(
                controller: searchController,
                textAlign: TextAlign.left,
                style: AppStyle.h2,
                maxLines: 1,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return null;
                    }
                    if (searchType == AppConstants.listOrderSearch[1]) {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return 'Mã đơn hàng là số';
                      }
                    }
                  }
                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {
                    if (searchType == AppConstants.listOrderSearch.first) {
                      orderSearch.userName =
                          (searchController.text.trim().isNotEmpty)
                              ? searchController.text.trim()
                              : null;
                      orderSearch.orderID = null;
                    } else if (searchType == AppConstants.listOrderSearch[1]) {
                      orderSearch.userName = null;
                      orderSearch.orderID =
                          (searchController.text.trim().isNotEmpty)
                              ? int.parse(searchController.text.trim())
                              : null;
                    }
                    onSearch(orderSearch);
                  }
                },
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (searchType ==
                              AppConstants.listOrderSearch.first) {
                            orderSearch.userName =
                                (searchController.text.trim().isNotEmpty)
                                    ? searchController.text.trim()
                                    : null;
                            orderSearch.orderID = null;
                          } else if (searchType ==
                              AppConstants.listOrderSearch[1]) {
                            orderSearch.userName = null;
                            orderSearch.orderID =
                                (searchController.text.trim().isNotEmpty)
                                    ? int.parse(searchController.text.trim())
                                    : null;
                          }
                          onSearch(orderSearch);
                        }
                      },
                      icon: const Icon(Icons.search)),
                  errorText: null,
                  errorStyle: AppStyle.errorStyle.copyWith(fontSize: 15),
                  label: Text(
                    'tìm kiếm',
                    style: AppStyle.h2,
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () async {
                    OrderSearch? search = await showDialog<OrderSearch>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Dialog(
                        child: FilterSearchOrder(orderSearch: orderSearch),
                        // child:
                        //     filterSearchOrderWidget(orderSearch: orderSearch),
                      ),
                    );
                    if (search != null) {
                      orderSearch.dateFrom = search.dateFrom;
                      orderSearch.dateTo = search.dateTo;
                      orderSearch.shipOrderStatus = orderSearch.shipOrderStatus;
                      if (searchType == AppConstants.listOrderSearch.first) {
                        orderSearch.userName =
                            (searchController.text.trim().isNotEmpty)
                                ? searchController.text.trim()
                                : null;
                        orderSearch.orderID = null;
                      } else if (searchType ==
                          AppConstants.listOrderSearch[1]) {
                        orderSearch.userName = null;
                        orderSearch.orderID =
                            (searchController.text.trim().isNotEmpty)
                                ? int.parse(searchController.text.trim())
                                : null;
                      }
                      onSearch(orderSearch);
                    }
                  },
                  icon: Icon(
                    Icons.filter_list_alt,
                    color: AppStyle.appColor,
                  )),
            )
          ],
        ),
      ),
    ),
  );
}
