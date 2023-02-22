import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/bloc/add_item_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/category/category_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/images/pick_images_cubit.dart';
import 'package:gsp23se37_supplier/src/model/category.dart';
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
            )
          ],
          child: BlocBuilder<AddItemBloc, AddItemState>(
            builder: (context, state) {
              return Column(
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
                                      itemBuilder: (context, index) => Padding(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        errorStyle: AppStyle.errorStyle.copyWith(fontSize: 15),
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
                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, categoryState) {
                        if (categoryState is CategoryLoadFailed) {
                          return Column(
                            children: [
                              Text(
                                categoryState.msg,
                                style: AppStyle.h2.copyWith(color: Colors.red),
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
                          _selectedCategory ??= categoryState.list.first;
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                value: _selectedCategory,
                                icon: const Icon(Icons.arrow_downward),
                                decoration: InputDecoration(
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
                                elevation: 16,
                                style: AppStyle.h2,
                                onChanged: (Category? value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCategory = value;
                                      if (value.categoryID != -1) {
                                        _selectedSubCategory =
                                            value.listSub.first;
                                      }
                                    });
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
                              if (_selectedCategory != null &&
                                  _selectedCategory!.categoryID != -1)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: DropdownButtonFormField(
                                    value: _selectedSubCategory,
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
                                        setState(() {
                                          _selectedSubCategory = value;
                                        });
                                      }
                                    },
                                    items: _selectedCategory!.listSub
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
                      },
                    ),
                    // thông số kỹ thật
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
