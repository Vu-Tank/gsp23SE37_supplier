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

  loadBrand() async {
    if (_isDisposed) {
      return;
    }
    emit(BrandLoading());
    ApiResponse apiResponse = await BrandRepositories.getBrands();
    if (apiResponse.isSuccess!) {
      List<Brand> list = apiResponse.data;
      if (isClosed) return;
      emit(BrandLoaded(list: list, brand: list.first));
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
        emit(BrandLoaded(list: list, brand: list[i]));
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
            emit(BrandLoaded(list: list, brand: list[i]));
          }
        }
      }
    }
  }
}
