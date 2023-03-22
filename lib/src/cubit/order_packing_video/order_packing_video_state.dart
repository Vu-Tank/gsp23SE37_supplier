part of 'order_packing_video_cubit.dart';

abstract class OrderPackingVideoState extends Equatable {
  const OrderPackingVideoState();

  @override
  List<Object> get props => [];
}

class OrderPackingVideoInitial extends OrderPackingVideoState {}

class OrderPackingVideoLoading extends OrderPackingVideoState {}

class OrderPackingVideoLoaded extends OrderPackingVideoState {}

class OrderPackingVideoUpLoaded extends OrderPackingVideoState {}

class OrderPackingVideoLoadFailed extends OrderPackingVideoState {
  final String msg;
  const OrderPackingVideoLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
