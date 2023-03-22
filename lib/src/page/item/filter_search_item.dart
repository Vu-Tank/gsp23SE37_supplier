import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/brand/brand_cubit.dart';
import 'package:gsp23se37_supplier/src/model/item/brand.dart';
import 'package:gsp23se37_supplier/src/model/item/item_search.dart';
import 'package:gsp23se37_supplier/src/model/item/model_brand.dart';
import 'package:gsp23se37_supplier/src/model/item/sort_model.dart';
import 'package:gsp23se37_supplier/src/model/item/sub_category.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

import '../../cubit/category/category_cubit.dart';
import '../../model/item/category.dart';

class FilterSeachItem extends StatefulWidget {
  const FilterSeachItem({super.key, required this.search});
  final ItemSearch search;
  @override
  State<FilterSeachItem> createState() => _FilterSeachItemState();
}

class _FilterSeachItemState extends State<FilterSeachItem> {
  final TextEditingController _max = TextEditingController();
  final TextEditingController _min = TextEditingController();
  late ItemSearch search;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search = widget.search;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit()
            ..loadCategory(
                categoryID: search.cateID, subCateId: search.subCateID),
        ),
        BlocProvider(
          create: (context) => BrandCubit()
            ..loadBrand(brandId: search.brandID, modelID: search.brandModelID),
        )
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Center(
                child: Text(
                  'Bộ lọc',
                  style: AppStyle.h2,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                if (state is CategoryLoadFailed) {
                  return blocLoadFailed(
                    msg: state.msg,
                    reload: () {
                      context.read<CategoryCubit>().loadCategory(
                          categoryID: search.cateID,
                          subCateId: search.subCateID);
                    },
                  );
                } else if (state is CategoryLoaded) {
                  return Column(
                    children: [
                      DropdownButtonFormField(
                        value: state.selected,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppStyle.appColor, width: 2),
                              borderRadius: BorderRadius.circular(40)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(40)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(40)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppStyle.appColor, width: 2),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        isExpanded: true,
                        validator: (value) {
                          return null;
                        },
                        elevation: 16,
                        style: AppStyle.h2,
                        onChanged: (Category? value) {
                          if (value != null) {
                            if (value.categoryID != search.cateID) {
                              search.subCateID = null;
                            }
                            if (value.categoryID != -1) {
                              search.cateID = value.categoryID;
                            }
                            context
                                .read<CategoryCubit>()
                                .selectedCategory(state.list, value);
                          }
                        },
                        items: state.list
                            .map<DropdownMenuItem<Category>>((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(
                              value.name,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: AppStyle.h2,
                            ),
                          );
                        }).toList(),
                      ),
                      if (state.selected.categoryID != -1)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: DropdownButtonFormField(
                            value: state.subCategory,
                            icon: const Icon(Icons.arrow_downward),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppStyle.appColor, width: 2),
                                  borderRadius: BorderRadius.circular(40)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(40)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(40)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppStyle.appColor, width: 2),
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            isExpanded: true,
                            validator: (value) {
                              return null;
                            },
                            elevation: 16,
                            style: AppStyle.h2,
                            onChanged: (SubCategory? value) {
                              if (value != null) {
                                if (value.sub_CategoryID != -1) {
                                  search.subCateID = value.sub_CategoryID;
                                }
                                context
                                    .read<CategoryCubit>()
                                    .selectedSubCategory(
                                        state.list, state.selected, value);
                              }
                            },
                            items: state.selected.listSub
                                .map<DropdownMenuItem<SubCategory>>(
                                    (SubCategory value) {
                              return DropdownMenuItem<SubCategory>(
                                value: value,
                                child: Text(
                                  value.sub_categoryName,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: AppStyle.h2,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              const SizedBox(
                height: 8.0,
              ),
              BlocBuilder<BrandCubit, BrandState>(
                builder: (context, state) {
                  if (state is BrandLoadFailed) {
                    return blocLoadFailed(
                      msg: state.msg,
                      reload: () {
                        context.read<BrandCubit>().loadBrand(
                            brandId: search.brandID,
                            modelID: search.brandModelID);
                      },
                    );
                  } else if (state is BrandLoaded) {
                    return Column(
                      children: [
                        DropdownButtonFormField(
                          value: state.brand,
                          icon: const Icon(Icons.arrow_downward),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppStyle.appColor, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppStyle.appColor, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          isExpanded: true,
                          validator: (value) {
                            return null;
                          },
                          elevation: 16,
                          style: AppStyle.h2,
                          onChanged: (Brand? value) {
                            if (value != null) {
                              if (search.brandID != value.brandID) {
                                search.brandModelID = null;
                              }
                              if (value.brandID != -1) {
                                search.brandID = value.brandID;
                              }
                              context
                                  .read<BrandCubit>()
                                  .selectedBrand(state.list, value);
                            }
                          },
                          items: state.list
                              .map<DropdownMenuItem<Brand>>((Brand value) {
                            return DropdownMenuItem<Brand>(
                              value: value,
                              child: Text(
                                value.name,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: AppStyle.h2,
                              ),
                            );
                          }).toList(),
                        ),
                        if (state.brand.brandID != -1)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: DropdownButtonFormField(
                              value: state.modelBrand,
                              icon: const Icon(Icons.arrow_downward),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppStyle.appColor, width: 2),
                                    borderRadius: BorderRadius.circular(40)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(40)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(40)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppStyle.appColor, width: 2),
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                              isExpanded: true,
                              validator: (value) {
                                return null;
                              },
                              elevation: 16,
                              style: AppStyle.h2,
                              onChanged: (ModelBrand? value) {
                                if (value != null) {
                                  if (value.brand_ModelID != -1) {
                                    search.brandModelID = value.brand_ModelID;
                                  }
                                  context.read<BrandCubit>().selectModelBrand(
                                      state.list, state.brand, value);
                                }
                              },
                              items: state.brand.listModel
                                  .map<DropdownMenuItem<ModelBrand>>(
                                      (ModelBrand value) {
                                return DropdownMenuItem<ModelBrand>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: AppStyle.h2,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              const SizedBox(
                height: 8.0,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 500),
                child:
                    DataTable(dataRowHeight: 70, headingRowHeight: 0, columns: [
                  DataColumn(label: Container()),
                  DataColumn(label: Container()),
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      'Sắp xếp',
                      style: AppStyle.h2,
                    )),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DropdownButtonFormField(
                          value: search.sortBy,
                          icon: const Icon(Icons.arrow_downward),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppStyle.appColor, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppStyle.appColor, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          isExpanded: true,
                          validator: (value) {
                            return null;
                          },
                          elevation: 16,
                          style: AppStyle.h2,
                          onChanged: (value) {
                            if (value != null) {
                              search.sortBy = value.toString();
                            }
                          },
                          items: AppConstants.listSortModel
                              .map<DropdownMenuItem<String>>((SortModel value) {
                            return DropdownMenuItem<String>(
                              value: value.query,
                              child: Text(
                                value.name,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: AppStyle.h2,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      TextFormField(
                        controller: _min,
                        textAlign: TextAlign.left,
                        style: AppStyle.h2,
                        maxLines: 1,
                        validator: (value) {
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(14),
                          CurrencyTextInputFormatter(
                            locale: 'vi_VN',
                            decimalDigits: 0,
                            symbol: 'VNĐ',
                          )
                        ],
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          errorText: null,
                          errorStyle:
                              AppStyle.errorStyle.copyWith(fontSize: 15),
                          label: Text(
                            'Giá tối thiểu',
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
                    DataCell(
                      TextFormField(
                        controller: _max,
                        textAlign: TextAlign.left,
                        style: AppStyle.h2,
                        maxLines: 1,
                        validator: (value) {
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(14),
                          CurrencyTextInputFormatter(
                            locale: 'vi_VN',
                            decimalDigits: 0,
                            symbol: 'VNĐ',
                          )
                        ],
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          errorText: null,
                          errorStyle:
                              AppStyle.errorStyle.copyWith(fontSize: 15),
                          label: Text(
                            'Giá tối đa',
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
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Center(
                        child: Text(
                          'Thiết lập lại',
                          style: AppStyle.h2.copyWith(color: Colors.blue),
                        ),
                      ),
                      onTap: () {
                        context.pop(search.copyWith(
                          brandID: null,
                          brandModelID: null,
                          cateID: null,
                          max: null,
                          min: null,
                          rate: null,
                          sortBy: null,
                          subCateID: null,
                        ));
                      },
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          'Tìm kiếm',
                          style: AppStyle.h2.copyWith(color: Colors.blue),
                        ),
                      ),
                      onTap: () {
                        context.pop(search);
                      },
                    ),
                  ]),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
