import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/district/district_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/province/province_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/ward/ward_cubit.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/validations.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

import '../../cubit/update_supplier_info/update_supplier_info_cubit.dart';
import '../../model/address/address.dart';
import '../../model/address/district.dart';
import '../../model/address/province.dart';
import '../../model/address/ward.dart';
import '../../utils/utils.dart';

class UserEditDialog extends StatefulWidget {
  const UserEditDialog({super.key, required this.type, required this.user});
  final String type;
  final User user;
  @override
  State<UserEditDialog> createState() => _UserEditDialogState();
}

class _UserEditDialogState extends State<UserEditDialog> {
  late Adderss address;
  late TextEditingController value;
  final formKey = GlobalKey<FormState>();
  late String otherValue;
  late DateTime dob;
  late String type;
  late User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = widget.type;
    user = widget.user;
    address = widget.user.addresses[0];
    value = TextEditingController(
        text: (widget.type == 'name')
            ? widget.user.userName
            : (widget.type == 'email')
                ? widget.user.email
                : (widget.type == 'address')
                    ? address.context
                    : null);
    otherValue = (widget.type == 'gender') ? widget.user.gender : '';
    dob = DateTime.parse(widget.user.dateOfBirth);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) => UpdateSupplierInfoCubit(),
          child: BlocConsumer<UpdateSupplierInfoCubit, UpdateSupplierInfoState>(
            listener: (context, state) {
              if (state is UpdateSupplierInfoSuccess) {
                context.read<AuthBloc>().add(UserUpdate(state.user));
                context.pop();
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (type == 'name')
                          ? 'Họ và tên'
                          : (type == 'email')
                              ? 'Email'
                              : (type == 'address')
                                  ? 'Địa chỉ'
                                  : '',
                      style: AppStyle.h2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 500,
                      child: (type == 'address')
                          ? addressWidget()
                          : (type == 'name' || type == 'email')
                              ? TextFormField(
                                  controller: value,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.h2,
                                  validator: (value) {
                                    if (type == 'name') {
                                      return Validations.valSupplierName(value);
                                    }
                                    if (type == 'email') {
                                      return Validations.valSupplierEmail(
                                          value);
                                    }
                                    return null;
                                  },
                                  maxLength: 100,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
                                    prefixIcon: const Icon(Icons.phone),
                                    errorStyle: AppStyle.errorStyle
                                        .copyWith(fontSize: 15),
                                    label: Text(
                                      (type == 'name')
                                          ? 'Họ và tên'
                                          : (type == 'email')
                                              ? 'Email'
                                              : '',
                                      style: AppStyle.h2,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                )
                              : (type == 'gender')
                                  ? Row(
                                      children: <Widget>[
                                        Text("Giới tính", style: AppStyle.h2),
                                        const SizedBox(width: 5.0),
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            value: user.gender,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            decoration: InputDecoration(
                                              errorMaxLines: 2,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppStyle.appColor,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            elevation: 16,
                                            style: AppStyle.h2,
                                            onChanged: (String? value) {
                                              if (value != null) {
                                                otherValue = value;
                                              }
                                            },
                                            items: AppConstants.genders
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: AppStyle.h2,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : (type == 'dob')
                                      ? StatefulBuilder(
                                          builder: (context, setInnerState) {
                                          DateTime? tmp;
                                          return InkWell(
                                            child: Row(
                                              children: <Widget>[
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                const Icon(
                                                  Icons.cake,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  'Ngày sinh',
                                                  style: AppStyle.h2,
                                                ),
                                                Text(
                                                  ': ${Utils.convertDateTimeToString((tmp == null) ? dob : tmp)}',
                                                  style: AppStyle.h2,
                                                )
                                              ],
                                            ),
                                            onTap: () async {
                                              DateTime? date =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime(dob.year,
                                                    dob.month, dob.day),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 1),
                                                helpText: 'Ngày sinh',
                                                selectableDayPredicate:
                                                    (DateTime? date) {
                                                  if (DateTime.now().year -
                                                          date!.year >=
                                                      14) {
                                                    if (DateTime.now().year -
                                                                date.year ==
                                                            14 &&
                                                        DateTime.now().month <
                                                            date.month) {
                                                      return false;
                                                    } else if (DateTime.now()
                                                                    .year -
                                                                date.year ==
                                                            14 &&
                                                        DateTime.now().month ==
                                                            date.month &&
                                                        DateTime.now().day <
                                                            date.day) {
                                                      return false;
                                                    }
                                                    return true;
                                                  }
                                                  return false;
                                                },
                                              );
                                              if (date != null) {
                                                setInnerState(() {
                                                  tmp = date;
                                                  dob = date;
                                                });
                                              }
                                            },
                                          );
                                        })
                                      : Container(),
                    ),
                    if (state is UpdateSupplierInfoFailed)
                      Text(
                        state.msg,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.errorStyle,
                      ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                'Thoát',
                                style: AppStyle.h2.copyWith(color: Colors.blue),
                              )),
                          TextButton(
                              onPressed: (state is UpdateSupplierInfoLoading)
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        switch (type) {
                                          case 'name':
                                            context
                                                .read<UpdateSupplierInfoCubit>()
                                                .updateName(
                                                    name: value.text.trim(),
                                                    user: user);
                                            return;
                                          case 'email':
                                            context
                                                .read<UpdateSupplierInfoCubit>()
                                                .updateEmail(
                                                    email: value.text.trim(),
                                                    user: user);
                                            return;
                                          case 'gender':
                                            context
                                                .read<UpdateSupplierInfoCubit>()
                                                .updateGender(
                                                    gender: otherValue,
                                                    user: user);
                                            return;
                                          case 'dob':
                                            context
                                                .read<UpdateSupplierInfoCubit>()
                                                .updateDOB(
                                                    dob: Utils
                                                        .convertDateTimeToStringToRegister(
                                                            dob),
                                                    user: user);
                                            return;
                                          case 'address':
                                            address.context = value.text.trim();
                                            context
                                                .read<UpdateSupplierInfoCubit>()
                                                .updateAddress(
                                                    address: address,
                                                    user: user);
                                            break;
                                          default:
                                            return;
                                        }
                                      }
                                    },
                              child: (state is UpdateSupplierInfoLoading)
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Lưu',
                                      style: AppStyle.h2
                                          .copyWith(color: Colors.blue),
                                    )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  addressWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProvinceCubit()..loadProvince(proviceName: address.province),
        ),
        BlocProvider(
          create: (context) => DistrictCubit(),
        ),
        BlocProvider(
          create: (context) => WardCubit(),
        )
      ],
      child: BlocConsumer<ProvinceCubit, ProvinceState>(
        listener: (context, provinceState) {
          if (provinceState is ProvinceLoaded) {
            address.province = provinceState.province.value;
            if (provinceState.province.key != '-1') {
              context.read<DistrictCubit>().loadDistrict(
                  provinceId: provinceState.province.key,
                  districtName: address.district);
            }
          }
        },
        builder: (context, provinceState) {
          if (provinceState is ProvinceLoaded) {
            return Column(
              children: [
                DropdownButtonFormField(
                  value: provinceState.province,
                  icon: const Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(40)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppStyle.appColor, width: 2),
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  isExpanded: true,
                  elevation: 16,
                  validator: (value) {
                    if (value == null || value.key == '-1') {
                      return 'Vui lòng chọn tỉnh';
                    }
                    return null;
                  },
                  style: AppStyle.h2,
                  onChanged: (Province? value) {
                    if (value != null) {
                      context.read<ProvinceCubit>().selectedProvince(
                          list: provinceState.provinces, province: value);
                    }
                  },
                  items: provinceState.provinces
                      .map<DropdownMenuItem<Province>>((Province value) {
                    return DropdownMenuItem<Province>(
                      value: value,
                      child: Text(
                        value.value,
                        style: AppStyle.h2,
                      ),
                    );
                  }).toList(),
                ),
                if (provinceState.province.key != '-1')
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: BlocConsumer<DistrictCubit, DistrictState>(
                      listener: (context, districtState) {
                        if (districtState is DistrictLoaded) {
                          address.district = districtState.district.value;
                          if (districtState.district.key != '-1') {
                            context.read<WardCubit>().loadWard(
                                districtId: districtState.district.key,
                                wardName: address.ward);
                          }
                        }
                      },
                      builder: (context, districtState) {
                        if (districtState is DistrictError) {
                          return blocLoadFailed(
                            msg: districtState.msg,
                            reload: () {
                              context.read<DistrictCubit>().loadDistrict(
                                  provinceId: provinceState.province.key);
                            },
                          );
                        } else if (districtState is DistrictLoaded) {
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                value: districtState.district,
                                icon: const Icon(Icons.arrow_downward),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
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
                                validator: (value) {
                                  if (value == null || value.key == '-1') {
                                    return 'Vui lòng chọn Huyện';
                                  }
                                  return null;
                                },
                                onChanged: (District? value) {
                                  if (value != null) {
                                    context
                                        .read<DistrictCubit>()
                                        .selectedDistrict(
                                            list: districtState.districts,
                                            district: value);
                                    context
                                        .read<WardCubit>()
                                        .loadWard(districtId: value.key);
                                  }
                                },
                                items: districtState.districts
                                    .map<DropdownMenuItem<District>>(
                                        (District value) {
                                  return DropdownMenuItem<District>(
                                    value: value,
                                    child: Text(
                                      value.value,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: AppStyle.h2,
                                    ),
                                  );
                                }).toList(),
                              ),
                              if (districtState.district.key != '-1')
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: BlocConsumer<WardCubit, WardState>(
                                    listener: (context, wardState) {
                                      if (wardState is WardLoaded) {
                                        address.ward = wardState.ward.value;
                                      }
                                    },
                                    builder: (context, wardState) {
                                      if (wardState is WardError) {
                                        return blocLoadFailed(
                                          msg: wardState.msg,
                                          reload: () {
                                            context.read<WardCubit>().loadWard(
                                                districtId:
                                                    districtState.district.key);
                                          },
                                        );
                                      } else if (wardState is WardLoaded) {
                                        return Column(
                                          children: [
                                            DropdownButtonFormField(
                                              value: wardState.ward,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              isExpanded: true,
                                              elevation: 16,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.key == '-1') {
                                                  return 'Vui lòng chọn phường, xã';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                errorMaxLines: 2,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.grey,
                                                                width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppStyle
                                                                .appColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40)),
                                              ),
                                              style: AppStyle.h2,
                                              onChanged: (Ward? value) {
                                                if (value != null) {
                                                  context
                                                      .read<WardCubit>()
                                                      .selectedWard(
                                                          list: wardState.wards,
                                                          ward: value);
                                                }
                                              },
                                              items: wardState.wards
                                                  .map<DropdownMenuItem<Ward>>(
                                                      (Ward value) {
                                                return DropdownMenuItem<Ward>(
                                                  value: value,
                                                  child: Text(
                                                    value.value,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    style: AppStyle.h2,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            if (wardState.ward.key != '-1')
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: TextFormField(
                                                  controller: value,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.h2,
                                                  validator: Validations
                                                      .valAddressString,
                                                  maxLength: 100,
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    errorMaxLines: 2,
                                                    prefixIcon:
                                                        const Icon(Icons.phone),
                                                    errorStyle: AppStyle
                                                        .errorStyle
                                                        .copyWith(fontSize: 15),
                                                    label: Text(
                                                      'Số nhà, đường',
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
                  ),
              ],
            );
          } else if (provinceState is ProvinceError) {
            return blocLoadFailed(
              msg: provinceState.msg,
              reload: () {
                context
                    .read<ProvinceCubit>()
                    .loadProvince(proviceName: address.province);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
