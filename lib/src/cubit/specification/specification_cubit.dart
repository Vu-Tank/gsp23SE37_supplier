import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/specification_repositories.dart';
import '../../model/specification.dart';
part 'specification_state.dart';

class SpecificationCubit extends Cubit<SpecificationState> {
  SpecificationCubit() : super(SpecificationInitial());
  loadSpecification({required int subCategoryID}) async {
    emit(SpecificationLoading());
    ApiResponse apiResponse = await SpecificationRepositories.getSpecification(
        subCategory: subCategoryID);
    if (apiResponse.isSuccess!) {
      emit(SpecificationLoaded(apiResponse.data));
    } else {
      emit(SpecificationLoadFailed(apiResponse.msg!));
    }
  }
}
