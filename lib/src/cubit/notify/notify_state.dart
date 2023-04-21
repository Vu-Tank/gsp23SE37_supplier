part of 'notify_cubit.dart';

abstract class NotifyState extends Equatable {
  const NotifyState();

  @override
  List<Object> get props => [];
}

class NotifyInitial extends NotifyState {}

class Notifyloading extends NotifyState {}

class NotifyFailed extends NotifyState {
  final String msg;
  const NotifyFailed(this.msg);
  @override
  List<Object> get props => [msg];
}

class NotifyLoaded extends NotifyState {
  final List<Notify> list;
  final int currentPage;
  final int totalPage;
  const NotifyLoaded(
      {required this.list, required this.currentPage, required this.totalPage});
  @override
  // TODO: implement props
  List<Object> get props => [list, currentPage, totalPage];
}
