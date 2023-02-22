part of 'pick_images_cubit.dart';

abstract class PickImagesState extends Equatable {
  const PickImagesState();

  @override
  List<Object> get props => [];
}

class PickImagesInitial extends PickImagesState {}

class PickImagesing extends PickImagesState {}

class PickImagesFailed extends PickImagesState {
  final String msg;
  const PickImagesFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class PickImagesSuccess extends PickImagesState {
  final List<XFile> images;
  final List<Uint8List> datas;
  const PickImagesSuccess({required this.images, required this.datas});
  @override
  // TODO: implement props
  List<Object> get props => [images, datas];
}
