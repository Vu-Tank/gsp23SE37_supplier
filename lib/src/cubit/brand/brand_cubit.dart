import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/model_brand.dart';
import 'package:gsp23se37_supplier/src/repositpries/brand_repositoriea.dart';
import '../../model/item/brand.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit() : super(BrandInitial());
  bool _isDisposed = false;
  void dispose() {
    _isDisposed = true;
    close();
  }

  loadBrand({int? brandId, int? modelID}) async {
    if (_isDisposed) {
      return;
    }
    emit(BrandLoading());
    ApiResponse apiResponse = await BrandRepositories.getBrands();
    if (apiResponse.isSuccess!) {
      List<Brand> list = apiResponse.data;
      Brand brand = list.first;
      ModelBrand? modelBrand;
      if (brandId != null) {
        for (var element in list) {
          if (element.brandID == brandId) {
            brand = element;

            if (modelID != null && modelID != -1) {
              modelBrand = brand.listModel.first;
              for (var element in brand.listModel) {
                if (element.brand_ModelID == modelID) {
                  modelBrand = element;
                }
              }
            }
          }
        }
      }
      if (isClosed) return;
      emit(BrandLoaded(list: list, brand: brand, modelBrand: modelBrand));
    } else {
      if (isClosed) return;
      emit(BrandLoadFailed(apiResponse.msg!));
    }
  }

  selectedBrand(List<Brand> list, Brand brand) {
    if (_isDisposed) {
      return;
    }
    emit(BrandLoading());
    for (var i = 0; i < list.length; i++) {
      if (list[i].brandID == brand.brandID) {
        ModelBrand? modelBrand;
        if (brand.brandID != -1) {
          modelBrand = brand.listModel.first;
        }
        if (isClosed) return;
        emit(BrandLoaded(list: list, brand: list[i], modelBrand: modelBrand));
      }
    }
  }

  selectModelBrand(List<Brand> list, Brand brand, ModelBrand modelBrand) async {
    if (_isDisposed) {
      return;
    }
    emit(BrandLoading());
    await Future.delayed(const Duration(milliseconds: 10));
    for (var i = 0; i < list.length; i++) {
      if (list[i].brandID == brand.brandID) {
        for (var j = 0; j < brand.listModel.length; j++) {
          if (list[i].listModel[j].brand_ModelID == modelBrand.brand_ModelID) {
            list[i].listModel[j].isActive == modelBrand.isActive;
            if (isClosed) return;
            emit(BrandLoaded(
                list: list, brand: list[i], modelBrand: modelBrand));
          }
        }
      }
    }
  }
}
