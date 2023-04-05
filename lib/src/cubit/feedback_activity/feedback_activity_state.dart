part of 'feedback_activity_cubit.dart';

abstract class FeedbackActivityState extends Equatable {
  const FeedbackActivityState();

  @override
  List<Object> get props => [];
}

class FeedbackActivityInitial extends FeedbackActivityState {}

class FeedbackActivityLoading extends FeedbackActivityState {}

class FeedbackActivityFailed extends FeedbackActivityState {
  final String msg;
  const FeedbackActivityFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class FeedbackActivitySuccess extends FeedbackActivityState {}
