import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/bloc/add_item_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/brand/brand_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/category/category_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/images/pick_images_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/specification/specification_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/sub_item/sub_item_cubit.dart';
import 'package:gsp23se37_supplier/src/model/brand.dart';
import 'package:gsp23se37_supplier/src/model/category.dart';
import 'package:gsp23se37_supplier/src/model/model_brand.dart';
import 'package:gsp23se37_supplier/src/model/sub_category.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_style.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  List<XFile> _listImages = [];
  List<Uint8List> _listImageDatas = [];
  final TextEditingController _itemName = TextEditingController();
  final List<TextEditingController> _specifi = [];
  Category? _selectedCategory;
  SubCategory? _selectedSubCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddItemBloc(),
            ),
            BlocProvider(
              create: (context) => PickImagesCubit(),
            ),
            BlocProvider(
              create: (context) => CategoryCubit()..loadCategory(),
            ),
            BlocProvider(
              create: (context) => SpecificationCubit(),
            ),
            BlocProvider(
              create: (context) => BrandCubit()..loadBrand(),
            ),
            BlocProvider(
              create: (context) => SubItemCubit(),
            ),
          ],
          child: BlocBuilder<AddItemBloc, AddItemState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hình Ảnh
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Chọn hình ảnh cho sản phẩm',
                          style: AppStyle.h2,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      BlocConsumer<PickImagesCubit, PickImagesState>(
                        listener: (context, pickImagesState) {
                          if (pickImagesState is PickImagesSuccess) {
                            _listImages = pickImagesState.images;
                            _listImageDatas = pickImagesState.datas;
                          }
                          if (pickImagesState is PickImagesFailed) {
                            MyDialog.showSnackBar(context, pickImagesState.msg);
                          }
                        },
                        builder: (context, pickImagesState) {
                          if (_listImageDatas.isNotEmpty &&
                              _listImages.isNotEmpty) {
                            return ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(dragDevices: {
                                PointerDeviceKind.mouse,
                                PointerDeviceKind.touch,
                              }),
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1),
                                        itemCount: _listImageDatas.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 200,
                                            height: 200,
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.topEnd,
                                              children: [
                                                Positioned.fill(
                                                  child: Image.memory(
                                                    _listImageDatas[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () => context
                                                        .read<PickImagesCubit>()
                                                        .deleteImage(
                                                            images: _listImages,
                                                            datas:
                                                                _listImageDatas,
                                                            index: index),
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<PickImagesCubit>()
                                                .cleanAll();
                                          },
                                          style: AppStyle.myButtonStyle,
                                          child: Text(
                                            'Xoá tất cả',
                                            style: AppStyle.h2
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<PickImagesCubit>()
                                                .pickImage(
                                                    datas: _listImageDatas,
                                                    images: _listImages);
                                          },
                                          style: AppStyle.myButtonStyle,
                                          child: Text(
                                            'Chọn thêm',
                                            style: AppStyle.h2
                                                .copyWith(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: AppStyle.appColor,
                                dashPattern: const [6.7],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                child: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Icon(
                                          Icons.image_outlined,
                                          color: AppStyle.appColor,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              context
                                                  .read<PickImagesCubit>()
                                                  .pickImage(
                                                      images: [], datas: []);
                                            },
                                            child: Text(
                                              'Chọn ảnh',
                                              style: AppStyle.h2,
                                            )),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      ]),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      // tên sản phẩm
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: _itemName,
                        textAlign: TextAlign.left,
                        style: AppStyle.h2,
                        maxLines: 1,
                        decoration: InputDecoration(
                          errorText: null,
                          errorStyle:
                              AppStyle.errorStyle.copyWith(fontSize: 15),
                          label: Text(
                            'Tên Sản phẩm',
                            style: AppStyle.h2,
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Chọn danh mục',
                        style: AppStyle.h2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      BlocConsumer<CategoryCubit, CategoryState>(
                        listener: (context, categoryState) {
                          if (categoryState is CategoryLoaded) {
                            _selectedCategory = categoryState.selected;
                            _selectedSubCategory = categoryState.subCategory;
                          }
                        },
                        builder: (context, categoryState) {
                          if (categoryState is CategoryLoadFailed) {
                            return Column(
                              children: [
                                Text(
                                  categoryState.msg,
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                TextButton(
                                    onPressed: () => context
                                        .read<CategoryCubit>()
                                        .loadCategory(),
                                    child: Text(
                                      'Thử lại',
                                      style: AppStyle.h2
                                          .copyWith(color: Colors.blue),
                                    ))
                              ],
                            );
                          } else if (categoryState is CategoryLoaded) {
                            return Column(
                              children: [
                                DropdownButtonFormField(
                                  value: categoryState.selected,
                                  icon: const Icon(Icons.arrow_downward),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppStyle.appColor, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                  ),
                                  isExpanded: true,
                                  elevation: 16,
                                  style: AppStyle.h2,
                                  onChanged: (Category? value) {
                                    if (value != null) {
                                      context
                                          .read<CategoryCubit>()
                                          .selectedCategory(
                                              categoryState.list, value);
                                    }
                                  },
                                  items: categoryState.list
                                      .map<DropdownMenuItem<Category>>(
                                          (Category value) {
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
                                if (categoryState.selected.categoryID != -1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: DropdownButtonFormField(
                                      value: categoryState.subCategory,
                                      icon: const Icon(Icons.arrow_downward),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppStyle.appColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                      ),
                                      isExpanded: true,
                                      elevation: 16,
                                      style: AppStyle.h2,
                                      onChanged: (SubCategory? value) {
                                        if (value != null) {
                                          context
                                              .read<CategoryCubit>()
                                              .selectedSubCategory(
                                                  categoryState.list,
                                                  categoryState.selected,
                                                  value);
                                          context
                                              .read<SpecificationCubit>()
                                              .loadSpecification(
                                                  subCategoryID:
                                                      value.sub_CategoryID);
                                        }
                                      },
                                      items: categoryState.selected.listSub
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
                                if (categoryState.subCategory != null &&
                                    categoryState.subCategory!.sub_CategoryID !=
                                        -1)
                                  // thông số kỹ thật
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: BlocBuilder<SpecificationCubit,
                                        SpecificationState>(
                                      builder: (context, specificationState) {
                                        if (specificationState
                                            is SpecificationLoadFailed) {
                                          return Column(
                                            children: [
                                              Text(
                                                specificationState.msg,
                                                style: AppStyle.h2.copyWith(
                                                    color: Colors.red),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              TextButton(
                                                  onPressed: () => context
                                                      .read<
                                                          SpecificationCubit>()
                                                      .loadSpecification(
                                                          subCategoryID:
                                                              categoryState
                                                                  .subCategory!
                                                                  .sub_CategoryID),
                                                  child: Text(
                                                    'Thử lại',
                                                    style: AppStyle.h2.copyWith(
                                                        color: Colors.blue),
                                                  ))
                                            ],
                                          );
                                        } else if (specificationState
                                            is SpecificationLoaded) {
                                          return Column(
                                            children: [
                                              Text(
                                                'Thông số Kỹ thuật',
                                                style: AppStyle.h1,
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: specificationState
                                                    .list.length,
                                                itemBuilder: (context, index) {
                                                  TextEditingController
                                                      controller =
                                                      TextEditingController();
                                                  _specifi.add(controller);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: TextField(
                                                      controller: controller,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle.h2,
                                                      maxLines: 1,
                                                      maxLength: 100,
                                                      decoration:
                                                          InputDecoration(
                                                        errorText: null,
                                                        errorStyle: AppStyle
                                                            .errorStyle
                                                            .copyWith(
                                                                fontSize: 15),
                                                        label: Text(
                                                          specificationState
                                                              .list[index]
                                                              .specificationName,
                                                          style: AppStyle.h2,
                                                        ),
                                                        border: const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
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
                      // MO TẢ
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Mô tả Sản phẩm',
                        style: AppStyle.h2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: _itemName,
                        textAlign: TextAlign.left,
                        style: AppStyle.h2,
                        maxLines: 2,
                        maxLength: 1000,
                        decoration: InputDecoration(
                          errorText: null,
                          errorStyle:
                              AppStyle.errorStyle.copyWith(fontSize: 15),
                          hintText: 'Mô tả thông tin về sản phẩm',
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      // Chọn phương tiện hỗ trợ
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Chọn phương tiên hỗ trợ',
                        style: AppStyle.h2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      BlocBuilder<BrandCubit, BrandState>(
                        builder: (context, brandState) {
                          if (brandState is BrandLoadFailed) {
                            return Column(
                              children: [
                                Text(
                                  brandState.msg,
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                TextButton(
                                    onPressed: () =>
                                        context.read<BrandCubit>().loadBrand(),
                                    child: Text(
                                      'Thử lại',
                                      style: AppStyle.h2
                                          .copyWith(color: Colors.blue),
                                    ))
                              ],
                            );
                          } else if (brandState is BrandLoaded) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: DropdownButtonFormField(
                                    value: brandState.brand,
                                    icon: const Icon(Icons.arrow_downward),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppStyle.appColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                    isExpanded: true,
                                    elevation: 16,
                                    style: AppStyle.h2,
                                    onChanged: (Brand? value) {
                                      if (value != null) {
                                        context
                                            .read<BrandCubit>()
                                            .selectedBrand(
                                                brandState.list, value);
                                        log(brandState.brand.toString());
                                      }
                                    },
                                    items: brandState.list
                                        .map<DropdownMenuItem<Brand>>(
                                            (Brand value) {
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
                                ),
                                if (brandState.brand.brandID != -1)
                                  DropdownButtonFormField(
                                    value: brandState.brand.listModel.first,
                                    icon: const Icon(Icons.arrow_downward),
                                    borderRadius: BorderRadius.circular(40),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppStyle.appColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                    isExpanded: true,
                                    elevation: 16,
                                    style: AppStyle.h2,
                                    items: brandState.brand.listModel
                                        .map<DropdownMenuItem<ModelBrand>>(
                                            (ModelBrand modelBrand) {
                                      return DropdownMenuItem<ModelBrand>(
                                        value: modelBrand,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: modelBrand.isActive,
                                              onChanged: (value) {},
                                            ),
                                            Text(
                                              modelBrand.name,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: AppStyle.h2,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        if (value.brand_ModelID == -1) return;
                                        value.isActive = !value.isActive;
                                        context
                                            .read<BrandCubit>()
                                            .selectModelBrand(brandState.list,
                                                brandState.brand, value);
                                      }
                                    },
                                  )
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      // Chọn phương tiện hỗ trợ
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Phân loại sản phẩm',
                        style: AppStyle.h2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      BlocBuilder<SubItemCubit, SubItemState>(
                        builder: (context, subItemState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: subItemState.listSub.length,
                                  itemBuilder: (context, index) {
                                    log(index.toString());
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DottedBorder(
                                                color: AppStyle.appColor,
                                                dashPattern: const [6.7],
                                                borderType: BorderType.RRect,
                                                radius:
                                                    const Radius.circular(12),
                                                child: Center(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.image_outlined,
                                                          color:
                                                              AppStyle.appColor,
                                                          size: 50,
                                                        ),
                                                        const SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        TextButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Chọn ảnh',
                                                              style:
                                                                  AppStyle.h2,
                                                            ))
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              TextField(
                                                controller: subItemState
                                                    .listSub[index].subName,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.h2,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  errorText: null,
                                                  errorStyle: AppStyle
                                                      .errorStyle
                                                      .copyWith(fontSize: 15),
                                                  label: Text(
                                                    'Tên hàng',
                                                    style: AppStyle.h2,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                controller: subItemState
                                                    .listSub[index].subPrice,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.h2,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  errorText: null,
                                                  errorStyle: AppStyle
                                                      .errorStyle
                                                      .copyWith(fontSize: 15),
                                                  label: Text(
                                                    'Giá',
                                                    style: AppStyle.h2,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                controller: subItemState
                                                    .listSub[index].subAmount,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.h2,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  errorText: null,
                                                  errorStyle: AppStyle
                                                      .errorStyle
                                                      .copyWith(fontSize: 15),
                                                  label: Text(
                                                    'Số lướng',
                                                    style: AppStyle.h2,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    );
                                  }),
                              ElevatedButton(
                                onPressed: () {
                                  if (subItemState.listSub.length >= 3) {
                                    MyDialog.showSnackBar(
                                        context, 'Thêm tối đã 3 mặc hằng');
                                  } else {
                                    context.read<SubItemCubit>().addSubItem();
                                  }
                                },
                                style: AppStyle.myButtonStyle,
                                child: Text(
                                  'Thêm loại hàng',
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
