import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/specification_repositories.dart';
import '../../model/specification.dart';
part 'specification_state.dart';

class SpecificationCubit extends Cubit<SpecificationState> {
  SpecificationCubit() : super(SpecificationInitial());
  bool _isDisposed = false;
  void dispose() {
    _isDisposed = true;
    close();
  }

  loadSpecification({required int subCategoryID}) async {
    if (_isDisposed) {
      return;
    }
    emit(SpecificationLoading());
    ApiResponse apiResponse = await SpecificationRepositories.getSpecification(
        subCategory: subCategoryID);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(SpecificationLoaded(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(SpecificationLoadFailed(apiResponse.msg!));
    }
  }
}
