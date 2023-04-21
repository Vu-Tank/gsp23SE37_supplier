import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());
  pickImage() async {
    if (isClosed) return;
    emit(PickImageing());
    try {
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        String? type = image.mimeType;
        if (type == null || !type.contains('image')) {
          if (isClosed) return;
          emit(const PickImageFailed('Vui lòng chọn file ảnh'));
          return;
        }
        var data = await image.readAsBytes();
        if (isClosed) return;
        emit(PickImageSuccess(image: image, data: data));
      } else {
        if (isClosed) return;
        emit(const PickImageFailed('Không có hình ảnh được chọn'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PickImageFailed(e.toString()));
    }
  }
}
