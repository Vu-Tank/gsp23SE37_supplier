import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsp23se37_supplier/src/model/item/item_search.dart';
import 'package:gsp23se37_supplier/src/page/item/filter_search_item.dart';

import '../../utils/app_style.dart';

Widget searchItemWidget(
    {required BuildContext context,
    required ItemSearch itemSearch,
    required TextEditingController searchController,
    required Function onSearch}) {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          controller: searchController,
          textAlign: TextAlign.left,
          style: AppStyle.h2,
          maxLines: 1,
          validator: (value) {
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          onFieldSubmitted: (value) {
            onSearch(itemSearch.copyWith(search: value));
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  onSearch(itemSearch.copyWith(
                      search: searchController.text.trim()));
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
              ItemSearch? search = await showDialog<ItemSearch>(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                  child: FilterSeachItem(search: itemSearch),
                ),
              );
              if (search != null) {
                itemSearch = search;
                onSearch(itemSearch);
              }
            },
            icon: Icon(
              Icons.filter_list_alt,
              color: AppStyle.appColor,
            )),
      )
    ],
  );
}
