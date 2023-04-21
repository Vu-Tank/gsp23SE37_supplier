import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_images_state.dart';

class PickImagesCubit extends Cubit<PickImagesState> {
  PickImagesCubit() : super(PickImagesInitial());
  pickImage(
      {required List<XFile> images, required List<Uint8List> datas}) async {
    emit(PickImagesing());
    try {
      if (images.length == 5 && datas.length == 5) {
        emit(const PickImagesFailed('Chỉ được chọn tối đa 5 hình'));
        return;
      }
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        String? type = image.mimeType;
        if (type == null || !type.contains('image')) {
          if (isClosed) return;
          emit(const PickImagesFailed('Vui lòng chọn file ảnh'));
          return;
        }
        final data = await image.readAsBytes();
        images.add(image);
        datas.add(data);
        emit(PickImagesSuccess(images: images, datas: datas));
      } else {
        emit(const PickImagesFailed('Không có hình ảnh được chọn'));
      }
    } catch (e) {
      emit(PickImagesFailed(e.toString()));
    }
  }

  cleanAll() {
    emit(const PickImagesSuccess(images: [], datas: []));
  }

  deleteImage(
      {required List<XFile> images,
      required List<Uint8List> datas,
      required int index}) {
    emit(PickImagesing());
    images.removeAt(index);
    datas.removeAt(index);
    emit(PickImagesSuccess(images: images, datas: datas));
  }
}
