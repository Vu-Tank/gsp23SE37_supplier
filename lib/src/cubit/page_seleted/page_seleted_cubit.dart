import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_seleted_state.dart';

class PageSeletedCubit extends Cubit<PageSeletedState> {
  PageSeletedCubit() : super(const PageSeletedInitial());
  selectPage({int? index}) {
    if (isClosed) return;
    emit(PageSelectedSuccess(index));
  }
}
