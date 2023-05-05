import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/page/over_view/over_view_page.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/register_supplier/register_supplier_bloc.dart';
import '../../cubit/district/district_cubit.dart';
import '../../cubit/province/province_cubit.dart';
import '../../cubit/ward/ward_cubit.dart';
import '../../model/address/district.dart';
import '../../model/address/province.dart';
import '../../model/address/ward.dart';
import '../../model/user.dart';
import '../../router/app_router_constants.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_style.dart';
import '../../utils/my_dialog.dart';
import '../../utils/utils.dart';
import '../../utils/validations.dart';
import '../../widget/bloc_load_failed.dart';

class RegisterSupplierPage extends StatefulWidget {
  const RegisterSupplierPage(
      {super.key,
      required this.firebaseToken,
      required this.phone,
      required this.uid});
  final String firebaseToken;
  final String phone;
  final String uid;
  @override
  State<RegisterSupplierPage> createState() => _RegisterSupplierPageState();
}

class _RegisterSupplierPageState extends State<RegisterSupplierPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? _dob;
  Province? _province;
  District? _district;
  Ward? _ward;
  String? _gender;
  bool? _isOk = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthBloc>().state is AuthAuthenticated) {
        GoRouter.of(context).pushReplacement('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đăng ký',
          style: AppStyle.apptitle,
        ),
        centerTitle: true,
        backgroundColor: AppStyle.appColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: BlocConsumer<RegisterSupplierBloc, RegisterSupplierState>(
              listener: (context, state) {
                if (state is RegisterSupplierFailed && state.msg != null) {
                  MyDialog.showSnackBar(context, state.msg!);
                }
              },
              builder: (context, state) {
                if (state is RegisterSupplierloading) {
                  return const CircularProgressIndicator();
                } else {
                  _gender = _gender ?? state.genders!.first;
                  // _province = _province ?? state.provinces!.first;
                  return Form(
                    key: formKey,
                    child: SizedBox(
                      width: 800,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox.fromSize(
                              size: const Size.fromRadius(150),
                              child: Image.network(
                                AppConstants.defaultAvatar,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: _fullName,
                            textAlign: TextAlign.left,
                            style: AppStyle.h2,
                            maxLines: 1,
                            validator: Validations.valAccountName,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              prefixIcon: const Icon(Icons.person),
                              // errorText: (state is RegisterSupplierFailed &&
                              //         state.fullNameError != null)
                              //     ? state.fullNameError
                              //     : null,
                              errorStyle:
                                  AppStyle.errorStyle.copyWith(fontSize: 15),
                              label: Text(
                                'Họ và tên',
                                style: AppStyle.h2,
                              ),

                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          // (state is RegisterSupplierFailed &&
                          //         state.fullNameError != null)
                          //     ? Padding(
                          //         padding: const EdgeInsets.only(top: 8.0),
                          //         child: Text(
                          //           state.fullNameError!,
                          //           style: AppStyle.errorStyle,
                          //         ),
                          //       )
                          //     : Container(),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            controller: _email,
                            textAlign: TextAlign.left,
                            style: AppStyle.h2,
                            maxLines: 1,
                            validator: Validations.valSupplierEmail,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              prefixIcon: const Icon(Icons.email_outlined),
                              errorStyle:
                                  AppStyle.errorStyle.copyWith(fontSize: 15),
                              label: Text(
                                'Email',
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
                          Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: (state is RegisterSupplierFailed &&
                                            state.dobError != null)
                                        ? Colors.red
                                        : Colors.black)),
                            child: InkWell(
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
                                  if (_dob != null)
                                    Text(
                                      ': ${Utils.convertDateTimeToString(_dob!)}',
                                      style: AppStyle.h2,
                                    ),
                                  (state is RegisterSupplierFailed &&
                                          state.dobError != null)
                                      ? Text(
                                          state.dobError!,
                                          style: AppStyle.errorStyle
                                              .copyWith(fontSize: 15),
                                        )
                                      : Container(),
                                ],
                              ),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  locale: const Locale("vi", "VN"),
                                  initialDate: DateTime(
                                      DateTime.now().year - 18,
                                      DateTime.now().month,
                                      DateTime.now().day),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  helpText: 'Ngày sinh',
                                  selectableDayPredicate: (DateTime? date) {
                                    if (DateTime.now().year - date!.year >=
                                        18) {
                                      if (DateTime.now().year - date.year ==
                                              18 &&
                                          DateTime.now().month < date.month) {
                                        return false;
                                      } else if (DateTime.now().year -
                                                  date.year ==
                                              18 &&
                                          DateTime.now().month == date.month &&
                                          DateTime.now().day < date.day) {
                                        return false;
                                      }
                                      return true;
                                    }
                                    return false;
                                  },
                                ).then((value) {
                                  setState(() {
                                    _dob = value;
                                  });
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          //gioi tinh
                          SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Text("Giới tính", style: AppStyle.h2),
                                SizedBox(
                                  width: width * 1 / 5,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    value: _gender,
                                    icon: const Icon(Icons.arrow_downward),
                                    decoration: InputDecoration(
                                      errorMaxLines: 2,
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
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 16,
                                    style: AppStyle.h2,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                    },
                                    items: state.genders!
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
                            ),
                          ),
                          // địa chỉ
                          const SizedBox(
                            height: 8.0,
                          ),
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    ProvinceCubit()..loadProvince(),
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
                                  // address.province = provinceState.province.value;
                                  _province = provinceState.province;
                                  if (provinceState.province.key != '-1') {
                                    context.read<DistrictCubit>().loadDistrict(
                                        provinceId: provinceState.province.key);
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
                                        borderRadius: BorderRadius.circular(20),
                                        isExpanded: true,
                                        elevation: 16,
                                        validator: (value) {
                                          if (value == null ||
                                              value.key == '-1') {
                                            return 'Vui lòng chọn tỉnh';
                                          }
                                          return null;
                                        },
                                        style: AppStyle.h2,
                                        onChanged: (Province? value) {
                                          if (value != null) {
                                            context
                                                .read<ProvinceCubit>()
                                                .selectedProvince(
                                                    list:
                                                        provinceState.provinces,
                                                    province: value);
                                          }
                                        },
                                        items: provinceState.provinces
                                            .map<DropdownMenuItem<Province>>(
                                                (Province value) {
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
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: BlocConsumer<DistrictCubit,
                                              DistrictState>(
                                            listener: (context, districtState) {
                                              if (districtState
                                                  is DistrictLoaded) {
                                                // address.district =
                                                //     districtState.district.value;
                                                _district =
                                                    districtState.district;
                                                if (districtState
                                                        .district.key !=
                                                    '-1') {
                                                  context
                                                      .read<WardCubit>()
                                                      .loadWard(
                                                          districtId:
                                                              districtState
                                                                  .district
                                                                  .key);
                                                }
                                              }
                                            },
                                            builder: (context, districtState) {
                                              if (districtState
                                                  is DistrictError) {
                                                return blocLoadFailed(
                                                  msg: districtState.msg,
                                                  reload: () {
                                                    context
                                                        .read<DistrictCubit>()
                                                        .loadDistrict(
                                                            provinceId:
                                                                provinceState
                                                                    .province
                                                                    .key);
                                                  },
                                                );
                                              } else if (districtState
                                                  is DistrictLoaded) {
                                                return Column(
                                                  children: [
                                                    DropdownButtonFormField(
                                                      value: districtState
                                                          .district,
                                                      icon: const Icon(
                                                          Icons.arrow_downward),
                                                      decoration:
                                                          InputDecoration(
                                                        errorMaxLines: 2,
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppStyle
                                                                    .appColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40)),
                                                      ),
                                                      isExpanded: true,
                                                      elevation: 16,
                                                      style: AppStyle.h2,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.key == '-1') {
                                                          return 'Vui lòng chọn Huyện';
                                                        }
                                                        return null;
                                                      },
                                                      onChanged:
                                                          (District? value) {
                                                        if (value != null) {
                                                          context
                                                              .read<
                                                                  DistrictCubit>()
                                                              .selectedDistrict(
                                                                  list: districtState
                                                                      .districts,
                                                                  district:
                                                                      value);
                                                          context
                                                              .read<WardCubit>()
                                                              .loadWard(
                                                                  districtId:
                                                                      value
                                                                          .key);
                                                        }
                                                      },
                                                      items: districtState
                                                          .districts
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      District>>(
                                                              (District value) {
                                                        return DropdownMenuItem<
                                                            District>(
                                                          value: value,
                                                          child: Text(
                                                            value.value,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            style: AppStyle.h2,
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                    if (districtState
                                                            .district.key !=
                                                        '-1')
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: BlocConsumer<
                                                            WardCubit,
                                                            WardState>(
                                                          listener: (context,
                                                              wardState) {
                                                            if (wardState
                                                                is WardLoaded) {
                                                              // address.ward =
                                                              //     wardState
                                                              //         .ward.value;
                                                              _ward = wardState
                                                                  .ward;
                                                            }
                                                          },
                                                          builder: (context,
                                                              wardState) {
                                                            if (wardState
                                                                is WardError) {
                                                              return blocLoadFailed(
                                                                msg: wardState
                                                                    .msg,
                                                                reload: () {
                                                                  context
                                                                      .read<
                                                                          WardCubit>()
                                                                      .loadWard(
                                                                          districtId: districtState
                                                                              .district
                                                                              .key);
                                                                },
                                                              );
                                                            } else if (wardState
                                                                is WardLoaded) {
                                                              return Column(
                                                                children: [
                                                                  DropdownButtonFormField(
                                                                    value:
                                                                        wardState
                                                                            .ward,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .arrow_downward),
                                                                    isExpanded:
                                                                        true,
                                                                    elevation:
                                                                        16,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value.key ==
                                                                              '-1') {
                                                                        return 'Vui lòng chọn phường, xã';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      errorMaxLines:
                                                                          2,
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: Colors.grey,
                                                                              width: 2),
                                                                          borderRadius: BorderRadius.circular(40)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: AppStyle.appColor,
                                                                              width: 2),
                                                                          borderRadius: BorderRadius.circular(40)),
                                                                    ),
                                                                    style:
                                                                        AppStyle
                                                                            .h2,
                                                                    onChanged:
                                                                        (Ward?
                                                                            value) {
                                                                      if (value !=
                                                                          null) {
                                                                        context.read<WardCubit>().selectedWard(
                                                                            list:
                                                                                wardState.wards,
                                                                            ward: value);
                                                                      }
                                                                    },
                                                                    items: wardState.wards.map<
                                                                        DropdownMenuItem<
                                                                            Ward>>((Ward
                                                                        value) {
                                                                      return DropdownMenuItem<
                                                                          Ward>(
                                                                        value:
                                                                            value,
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .value,
                                                                          overflow:
                                                                              TextOverflow.fade,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              AppStyle.h2,
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                  if (wardState
                                                                          .ward
                                                                          .key !=
                                                                      '-1')
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _address,
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: AppStyle
                                                                            .h2,
                                                                        validator:
                                                                            Validations.valAddressString,
                                                                        maxLength:
                                                                            100,
                                                                        maxLines:
                                                                            1,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          errorMaxLines:
                                                                              2,
                                                                          prefixIcon:
                                                                              const Icon(Icons.phone),
                                                                          errorStyle: AppStyle
                                                                              .errorStyle
                                                                              .copyWith(fontSize: 15),
                                                                          label:
                                                                              Text(
                                                                            'Địa chỉ (số nhà, tên đường)',
                                                                            style:
                                                                                AppStyle.h2,
                                                                          ),
                                                                          border:
                                                                              const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              );
                                                            } else {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                                          .loadProvince();
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          CheckboxListTile(
                            value: _isOk,
                            onChanged: (value) {
                              setState(() {
                                _isOk = value;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Row(
                              children: <Widget>[
                                Text(
                                  'Đồng ý với các ',
                                  style: AppStyle.h2,
                                ),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              const OverViewPage(),
                                              IconButton(
                                                  onPressed: () =>
                                                      context.pop(),
                                                  icon: const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Điều khoản',
                                      style: AppStyle.h2
                                          .copyWith(color: Colors.blue),
                                    )),
                                Text(
                                  ' của ESMP',
                                  style: AppStyle.h2,
                                ),
                              ],
                            ),
                          ),
                          (state is RegisterSupplierFailed &&
                                  state.agreeError != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    state.agreeError!,
                                    style: AppStyle.errorStyle
                                        .copyWith(fontSize: 15),
                                  ),
                                )
                              : Container(),
                          //buttom
                          const SizedBox(
                            height: 8.0,
                          ),
                          SizedBox(
                            height: 56.0,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (state is RegisterSuppliering)
                                  ? null
                                  : () {
                                      final check =
                                          formKey.currentState!.validate();
                                      context
                                          .read<RegisterSupplierBloc>()
                                          .add(RegisterSupplierPressed(
                                            check: check,
                                            fullName: _fullName.text.trim(),
                                            email: _email.text.trim(),
                                            dob: _dob,
                                            address: _address.text.trim(),
                                            gender: _gender!,
                                            province: _province!,
                                            district: _district,
                                            ward: _ward,
                                            isAgree: _isOk!,
                                            token: widget.firebaseToken,
                                            phone: widget.phone,
                                            uid: widget.uid,
                                            onSuccess: (User user) {
                                              context.read<AuthBloc>().add(
                                                  UserLoggedIn(user: user));
                                              GoRouter.of(context)
                                                  .pushReplacementNamed(
                                                      AppRouterConstants
                                                          .registerStore);
                                            },
                                          ));
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppStyle.appColor,
                                disabledBackgroundColor:
                                    AppStyle.appColor.withOpacity(0.2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                              child: (state is RegisterSuppliering)
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Đăng ký',
                                      style: AppStyle.buttom,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )),
        ),
      ),
    );
  }
}
